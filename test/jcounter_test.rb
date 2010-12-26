require File.dirname(__FILE__) + '/test_helper'
 
class JcounterTest < Test::Unit::TestCase
  load_schema
 
  class User < ActiveRecord::Base
  end
 
  class Link < ActiveRecord::Base
  end
 
  def test_schema_has_loaded_correctly
    assert_equal [], User.all
    assert_equal [], Link.all
  end
 
end