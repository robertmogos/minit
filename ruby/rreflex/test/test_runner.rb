require "test/unit"
require "minit/runner"

class TestRunner < Test::Unit::TestCase
  def test_interfaces
    runner = Minit::Runner.new(['/Users/adi/Desktop/apocope/dev/minit/MinitSample/minit_reflex/doxy/xml',
                                '/Users/adi/Desktop/apocope/dev/minit/MinitSample/minit_reflex/helpers'])
    runner.run
  end
end