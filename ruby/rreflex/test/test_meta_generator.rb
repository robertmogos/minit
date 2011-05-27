require "test/unit"
require "meta_generator"
require "reflex/class"
require "reflex/method"
require "reflex/method_argument"
require "reflex/annotation"

class TestMetaGenerator < Test::Unit::TestCase
  def get_test_class
    cls = RReflex::Class.new('ClassA')
    met = RReflex::Method.new('initWithString:namedString:annotatedString:','id')
    first_argument = RReflex::MethodArgument.new("NSString *")
    first_argument.annotations = []
    first_argument.name = 'str'
    seccond_argument = RReflex::MethodArgument.new("NSString *")
    seccond_argument.label = "[namedString]"
    seccond_argument.annotations = [RReflex::Annotation.new('@InjectNamed(SomeString)')]
    seccond_argument.name = 'named'
    third_argument = RReflex::MethodArgument.new("NSString *")
    third_argument.label = "[annotatedString]"
    third_argument.annotations = [RReflex::Annotation.new('@AnnotatedString')]
    third_argument.name = 'anno'
    met.arguments = [first_argument,seccond_argument,third_argument]
    cls.methods = [met]
    return cls
  end
  def test_generate
    cls = get_test_class
    g = MetaGenerator.new();
    code = g.objc(cls)
    puts code
  end
  # def test_generate
  #   cls = get_test_class
  #   g = MetaGenerator.new();
  #   g.instance_variable_set(:@cls, cls)
  #   code = g.constructor_params
  # end
end

