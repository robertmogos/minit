require "test/unit"
require "rexml/document"
require "minit/doxy_parser.rb"

class TestDoxyParser < Test::Unit::TestCase
  def test_class_xml
    xml = <<-XML
    <?xml version="1.0" encoding="UTF-8" standalone="no"?>
    <doxygen xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xsi:noNamespaceSchemaLocation="compound.xsd" version="1.7.4">
        <compounddef id="interface_class_a" kind="class" prot="public">
            <compoundname>ClassA</compoundname>
            <includes refid="_class_a_8h" local="no">ClassA.h</includes>
            <sectiondef kind="public-func">
                <memberdef kind="function" id="interface_class_a_1ac7628a851830f4f47c582ad2532ed9dc" prot="public" static="no" const="no" explicit="no" inline="no" virt="virtual">
                    <type>id</type>
                    <definition>id ClassA::initWithString:namedString:annotatedString:</definition>
                    <argsstring>(NSString *str,[namedString] NSString *named,[annotatedString] NSString *anno)</argsstring>
                    <name>initWithString:namedString:annotatedString:</name>
                    <param>
                        <type>NSString *</type>
                        <declname>str</declname>
                    </param>
                    <param>
                        <attributes>[namedString]</attributes>
                        <type>NSString *</type>
                        <declname>named</declname>
                    </param>
                    <param>
                        <attributes>[annotatedString]</attributes>
                        <type>NSString *</type>
                        <declname>anno</declname>
                    </param>
                    <briefdescription>
                        <para>A simple initializer annotated for dependency injection [minit]. </para>
                    </briefdescription>
                    <detaileddescription>
                        <para>
                            <parameterlist kind="param">
                                <parameteritem>
                                    <parameternamelist>
                                        <parametername>str</parametername>
                                    </parameternamelist>
                                    <parameterdescription>
                                        <para>- this will be simply injected as a string </para>
                                    </parameterdescription>
                                </parameteritem>
                                <parameteritem>
                                    <parameternamelist>
                                        <parametername>named</parametername>
                                    </parameternamelist>
                                    <parameterdescription>
                                        <para>@InjectNamed(SomeString) </para>
                                    </parameterdescription>
                                </parameteritem>
                                <parameteritem>
                                    <parameternamelist>
                                        <parametername>anno</parametername>
                                    </parameternamelist>
                                    <parameterdescription>
                                        <para>@AnnotatedString </para>
                                    </parameterdescription>
                                </parameteritem>
                            </parameterlist>
                            <simplesect kind="return">
                                <para>a newly initialized object </para>
                            </simplesect>
                        </para>
                    </detaileddescription>
                    <inbodydescription>
            </inbodydescription>
                    <location file="/Users/adi/Desktop/apocope/dev/minit/tests/resources/objc/ClassA.h" line="24"/>
                </memberdef>
            </sectiondef>
            <briefdescription>
        </briefdescription>
            <detaileddescription>
        </detaileddescription>
            <location file="/Users/adi/Desktop/apocope/dev/minit/tests/resources/objc/ClassA.h" line="14" bodyfile="/Users/adi/Desktop/apocope/dev/minit/tests/resources/objc/ClassA.h" bodystart="14" bodyend="-1"/>
            <listofallmembers>
                <member refid="interface_class_a_1ac7628a851830f4f47c582ad2532ed9dc" prot="public" virt="virtual">
                    <scope>ClassA</scope>
                    <name>initWithString:namedString:annotatedString:</name>
                </member>
            </listofallmembers>
        </compounddef>
    </doxygen>
    XML
    parser = Minit::DoxyParser.new()
    r = parser.parse(xml)
    m = r[0].methods[0]
    assert_not_nil(m)
    assert_equal(m.returnType,'id')
    assert_equal(m.name,'initWithString:namedString:annotatedString:')
    assert_equal(m.arguments.length, 3)
    assert_equal(m.arguments[0].label,nil)
    assert_equal(m.arguments[0].name,'str')
    assert_equal(m.arguments[0].type,"NSString *")
    assert_equal(m.arguments[0].annotations.size,0)
    assert_equal(m.arguments[1].label,'[namedString]')
    assert_equal(m.arguments[1].annotations[0].name,'@InjectNamed(SomeString)')
    assert_equal(m.arguments[1].name,'named')
    assert_equal(m.arguments[1].type,"NSString *")
    assert_equal(m.arguments[2].label,'[annotatedString]')
    assert_equal(m.arguments[2].annotations[0].name,'@AnnotatedString')
    assert_equal(m.arguments[2].name,'anno')
    assert_equal(m.arguments[2].type,"NSString *")
    puts r.inspect
  end
  def test_f2unction_xml
    xml = <<-XML
      <memberdef kind="function" id="interface_class_a_1ac7628a851830f4f47c582ad2532ed9dc" prot="public" static="no" const="no" explicit="no" inline="no" virt="virtual">
        <type>id</type>
        <definition>id ClassA::initWithString:namedString:annotatedString:</definition>
        <argsstring>(NSString *str,[namedString] NSString *named,[annotatedString] NSString *anno)</argsstring>
        <name>initWithString:namedString:annotatedString:</name>
        <param>
          <type>NSString *</type>
          <declname>str</declname>
        </param>
        <param>
          <attributes>[namedString]</attributes>
          <type>NSString *</type>
          <declname>named</declname>
        </param>
        <param>
          <attributes>[annotatedString]</attributes>
          <type>NSString *</type>
          <declname>anno</declname>
        </param>
        <briefdescription>
        </briefdescription>
        <detaileddescription>
        </detaileddescription>
        <inbodydescription>
        </inbodydescription>
        <location file="/Users/adi/Desktop/apocope/dev/minit/tests/resources/objc/ClassA.h" line="19"/>
      </memberdef>
    XML
    function_doc = REXML::Document.new(xml)
    parser = Minit::DoxyParser.new()
    r = parser.parse_method function_doc.root
    assert_not_nil(r)
    assert_equal(r.returnType,'id')
    assert_equal(r.name,'initWithString:namedString:annotatedString:')
    assert_equal(r.arguments.length, 3)
    assert_equal(r.arguments[0].label,nil)
    assert_equal(r.arguments[0].name,'str')
    assert_equal(r.arguments[0].type,"NSString *")
    assert_equal(r.arguments[1].label,'[namedString]')
    assert_equal(r.arguments[1].name,'named')
    assert_equal(r.arguments[1].type,"NSString *")
    assert_equal(r.arguments[2].label,'[annotatedString]')
    assert_equal(r.arguments[2].name,'anno')
    assert_equal(r.arguments[2].type,"NSString *")
  end
  def test_parse_annotations
    xml = <<-XML
    <detaileddescription>
        <para>
            <parameterlist kind="param">
                <parameteritem>
                    <parameternamelist>
                        <parametername>str</parametername>
                    </parameternamelist>
                    <parameterdescription>
                        <para>- this will be simply injected as a string </para>
                    </parameterdescription>
                </parameteritem>
                <parameteritem>
                    <parameternamelist>
                        <parametername>named</parametername>
                    </parameternamelist>
                    <parameterdescription>
                        <para>@InjectNamed(SomeString)</para>
                    </parameterdescription>
                </parameteritem>
                <parameteritem>
                    <parameternamelist>
                        <parametername>anno</parametername>
                    </parameternamelist>
                    <parameterdescription>
                        <para>@AnnotatedString </para>
                    </parameterdescription>
                </parameteritem>
            </parameterlist>
            <simplesect kind="return">
                <para>a newly initialized object </para>
            </simplesect>
        </para>
    </detaileddescription>
    XML
    annotation_doc = REXML::Document.new(xml)
    parser = Minit::DoxyParser.new()
    annotations = parser.parse_annotations annotation_doc
    assert_equal(annotations['named'][0].name,'@InjectNamed(SomeString)')
    assert_equal(annotations['anno'][0].name,'@AnnotatedString')
  end
end
