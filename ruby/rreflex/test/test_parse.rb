require "test/unit"
require "rexml/document"
require "parse"

class TestParse < Test::Unit::TestCase
  def test_class_xml
    xml = <<-XML
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
          </briefdescription>
          <detaileddescription>
          </detaileddescription>
          <inbodydescription>
          </inbodydescription>
          <location file="/Users/adi/Desktop/apocope/dev/minit/tests/resources/objc/ClassA.h" line="19"/>
        </memberdef>
        <memberdef kind="function" id="interface_class_a_1ac23740de2fdc768228de75d5c11b7501" prot="public" static="no" const="no" explicit="no" inline="no" virt="virtual">
          <type>id</type>
          <definition>id ClassA::initWithString:samedString:annotatedString:</definition>
          <argsstring>(NSString *str,[samedString] id named,[annotatedString] NSString *anno)</argsstring>
          <name>initWithString:samedString:annotatedString:</name>
          <param>
            <type>NSString *</type>
            <declname>str</declname>
          </param>
          <param>
            <attributes>[samedString]</attributes>
            <type>id</type>
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
          <location file="/Users/adi/Desktop/apocope/dev/minit/tests/resources/objc/ClassA.m" line="14" bodyfile="/Users/adi/Desktop/apocope/dev/minit/tests/resources/objc/ClassA.m" bodystart="14" bodyend="16"/>
        </memberdef>
        </sectiondef>
      <briefdescription>
      </briefdescription>
      <detaileddescription>
      </detaileddescription>
      <location file="/Users/adi/Desktop/apocope/dev/minit/tests/resources/objc/ClassA.h" line="14" bodyfile="/Users/adi/Desktop/apocope/dev/minit/tests/resources/objc/ClassA.h" bodystart="14" bodyend="-1"/>
      <listofallmembers>
        <member refid="interface_class_a_1ac7628a851830f4f47c582ad2532ed9dc" prot="public" virt="virtual"><scope>ClassA</scope><name>initWithString:namedString:annotatedString:</name></member>
        <member refid="interface_class_a_1ac23740de2fdc768228de75d5c11b7501" prot="public" virt="virtual"><scope>ClassA</scope><name>initWithString:samedString:annotatedString:</name></member>
      </listofallmembers>
    XML
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
    parser = Parse.new()
    r = parser.do_method function_doc.root
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
  def test_extract_annotations
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
    parser = Parse.new()
    annotations = parser.extract_annotations annotation_doc.root
    assert_equal(annotations['named'][0].name,'@InjectNamed(SomeString)')
    assert_equal(annotations['anno'][0].name,'@AnnotatedString')
  end
end
