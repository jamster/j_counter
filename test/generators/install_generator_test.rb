require File.dirname(__FILE__) + '/../test_helper'
 
class InstallGeneratorTest < Rails::Generators::TestCase
  tests JCounter::InstallGenerator
  
  destination File.expand_path("../../tmp", __FILE__)
  setup :prepare_destination

  test "Assert all views are properly created with no params" do
    run_generator
    assert_files
  end
  
  def assert_files(scope = nil, template_engine = nil)
    assert_file "public/javascripts/jcounter.js"
    assert_file "public/stylesheets/jcounter.css"
  end

end