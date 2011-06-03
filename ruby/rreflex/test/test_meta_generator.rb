require "test/unit"
require "minit/meta_generator"
require "minit/reflexion/class"
require "minit/reflexion/method"
require "minit/reflexion/method_argument"
require "minit/reflexion/annotation"

class TestMetaGenerator < Test::Unit::TestCase
  def get_test_class
    cls = Minit::Reflexion::Class.new('ClassA')
    met = Minit::Reflexion::Method.new('initWithString:namedString:annotatedString:','id')
    first_argument = Minit::Reflexion::MethodArgument.new("NSString *")
    first_argument.annotations = []
    first_argument.name = 'str'
    seccond_argument = Minit::Reflexion::MethodArgument.new("NSString *")
    seccond_argument.label = "[namedString]"
    seccond_argument.annotations = [Minit::Reflexion::Annotation.new('@InjectNamed(SomeString)')]
    seccond_argument.name = 'named'
    third_argument = Minit::Reflexion::MethodArgument.new("NSString *")
    third_argument.label = "[annotatedString]"
    third_argument.annotations = [Minit::Reflexion::Annotation.new('@AnnotatedString')]
    third_argument.name = 'anno'
    met.arguments = [first_argument,seccond_argument,third_argument]
    cls.methods = [met]
    return cls
  end
  def test_generate
    cls = get_test_class
    g = Minit::MetaGenerator.new();
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

