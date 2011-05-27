require 'erb'

# This class is generating the  objective-c  DI helper code used by the MINIT.
# Once doxygen output is parsed with DoxyParser, this class can generate the 
# class_builder helper methods used by MINIT 
class MetaGenerator
  
  # generates the objective-c code
  def objc cls
    @cls = cls
    tpl = get_template
    code = ERB.new(tpl, 0, "%<>")
    return code.result(binding)
  end
  
  # the injection helper template
  def get_template
    template = %q{
       // Automaticaly generated by MINIT with RRflex
       #import "<%= cls.name %>.h"
       
       @interface "<%= cls.name %>.h" ( MINITInjectionHelper )

       +(id)class_builder:(id<ATInject>)inject;

       @end
       
       @implementation "<%= cls.name %>.h" ( MINITInjectionHelper )

       +(id)class_builder:(id<ATInject>)inject{
         <%= constructor_params %>
         return [[[self alloc] <%= constructor_call %>] autorelease];
       }
      
       @end
      }.gsub(/^       /, '')
  end
  
  # Generates the code used to build all constructor params
  def constructor_params
    initializer = @cls.methods[0]
    constructor_params = ''
    return constructor_params if initializer.arguments.length < 1
    #puts initializer.arguments.inspect
    initializer.arguments.each_with_index { |p , i|
      build_code = param_injection_code(p)
      constructor_params += "#{p.type} p_#{i}_#{initializer.arguments[i].name} = " + build_code + ";\n  "
    }
    return constructor_params
  end

  # Generates the initializer call code used to build the class instance
  def constructor_call
    initializer = @cls.methods[0]
    init_call = ''
    param_names = initializer.name.split(':')
    return param_names[0] if param_names.length == 1
    param_names.each_with_index {|p,i|
      init_call+="#{p}: p_#{i}_#{initializer.arguments[i].name} "
    }
    return init_call
  end
  # Returns the appropriate injection code for a method argument
  def param_injection_code(method_argument)
    return param_injection_code_instance(method_argument) if method_argument.annotations.length == 0
    namedAnnotation = method_argument.annotations.find {|anno| anno.name =~ /^@InjectNamed/}
    return param_injection_code_named(method_argument,namedAnnotation) if !namedAnnotation.nil?
    return param_injection_code_annotated(method_argument)
  end
  # produces something like [inject instanceOf:[NSString class] named:@"SomeString"];
  def param_injection_code_named(method_argument,namedAnnotation)
    arg_class = method_argument.type.split(' ')[0]
    annotation_name = namedAnnotation.name.gsub(%r{^(@InjectNamed\()|(\))}, '')
    return %{[inject instanceOf:[#{arg_class} class] named:@"#{annotation_name}"]}
  end
  # produces something like [inject instanceOf:[NSString class]];
  def param_injection_code_instance(method_argument)
    arg_class = method_argument.type.split(' ')[0]
    return "[inject instanceOf:[#{arg_class} class]]"
  end
  # produces something like [inject instanceOf:[NSString class] annotated:[AnnotatedString class]];
  def param_injection_code_annotated(method_argument)
    arg_class = method_argument.type.split(' ')[0]
    # annotation name without @
    annotation_type = method_argument.annotations[0].name.split('@')[1]
    return %{[inject instanceOf:[#{arg_class} class] annotated:[#{annotation_type} class]]}
  end
end