require 'fileutils'
require 'minit/doxy_parser'
require 'minit/meta_generator'
module Minit
  class Runner
    def initialize(argv)
      @argv = argv
    end
    def run
      return nil if @argv.empty?
      code_map = generate_code @argv[0]
      update_files(@argv[1],code_map)
    end
    def update_files(path,code_map)
      code_map.keys.each { |class_name|
        if !code_map[class_name].nil? then
          file_name = %{#{path}/#{class_name}+MINITInjectionHelper.m}
          mFile = File.new(file_name, "w")
          mFile.write(code_map[class_name])
          mFile.close
        end
      }
    end
    def generate_code(path)
      interfaces = find_interfaces(path)
      classes = {}
      parser = Minit::DoxyParser.new()
      g = Minit::MetaGenerator.new();
      interfaces.each do |file|
        xml = File.open(file) { |f| f.read }
        cls =  parser.parse(xml)
        classes[cls[0].name] = g.objc(cls[0])
      end
      return classes
    end
    def find_interfaces(path)
      return Dir.glob(path + '/interface*.xml')
    end
    
  end
end