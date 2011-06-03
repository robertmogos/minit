#!/usr/bin/ruby
$: << File.expand_path(File.dirname(__FILE__))+'/../lib'
require "minit/runner"
puts ARGV.inspect
runner = Minit::Runner.new(ARGV)
runner.run