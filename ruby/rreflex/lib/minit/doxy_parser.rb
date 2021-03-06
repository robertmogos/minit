require 'rexml/document'
require "minit/reflexion/method_argument"
require "minit/reflexion/method"
require "minit/reflexion/class"
require "minit/reflexion/annotation"
include REXML

module Minit
  class DoxyParser
    
    def parse(xml)
      doc = Document.new(xml)
      @interfaces = []
      doc.elements.each("//compounddef[@kind='class']") {|c| parse_class c}
      return @interfaces
    end
  
    def parse_class i
      @c = 0
      interfaceName = i.elements['compoundname']
      includes = i.elements['includes']
      if includes.nil? then
        interfaceHeader = ''
      else
        interfaceHeader = includes.text
      end
      if interfaceName.nil?  then 
        puts i.inspect + "missing name for class"
        return
      else
        interfaceName = interfaceName.text
      end
      interface = Minit::Reflexion::Class.new(interfaceName)
      interface.header_file = interfaceHeader
      i.elements.each("//memberdef[@kind='function']") {|f|
        @c += 1
        function = parse_method f
        interface.methods<< function;
        }
      @interfaces << interface;
    end
  
    def parse_method f
      if f.elements['type'].nil? then return nil end
      if f.elements['name'].nil? then return nil end
      method = Minit::Reflexion::Method.new(f.elements['name'].text , f.elements['type'].text)
      args = []
      f.elements.each('param') do |p|
        if p.elements['type'].nil? then
          puts p.inspect + 'has no type'
          return nil
        end
        type =  p.elements['type'].text
        arg =  Minit::Reflexion::MethodArgument.new(type)
        arg.name = p.elements['declname'].text unless p.elements['declname'].nil?
        arg.label = p.elements['attributes'].text unless p.elements['attributes'].nil?
        args << arg
      end
      method.arguments = args;
      annotations = parse_annotations f
      add_annotations(method,annotations)
      return method
    end
  
    def add_annotations method, annotations    
      method.arguments.each do |arg|
        if annotations[arg.name].nil? then
          arg.annotations = []
        else
          arg.annotations = annotations[arg.name]
        end
      end
    end
  
    def parse_annotations desc
      annotations = {}
      desc.elements.each("detaileddescription/para/parameterlist[@kind='param']/parameteritem"){ |p|
        if !p.elements['parameterdescription/para'].nil? then
          comment = p.elements['parameterdescription/para'].text
          annoMatch = /@[^ ]*/.match(comment)
          anno = annoMatch[0] if annoMatch
          if (anno) then
            if !p.elements['parameternamelist/parametername'].nil? then
              name = p.elements['parameternamelist/parametername'].text
              annotations["#{name}"] = [] if annotations["#{name}"].nil?
              annotations["#{name}"] << Minit::Reflexion::Annotation.new(anno)
            end
          end
        end
      } 
      return annotations
    end
  end
end