require File.dirname(__FILE__) + '/../test_helper'
include JCounterHelper
 
class JCounterHelperTest < Test::Unit::TestCase
  
  def test_j_counter_default
    assert_equal default_javascript, j_counter_runner
  end

  def test_j_counter_with_options
    assert_equal default_javascript("5.0", "100", "100"), j_counter_runner(:slope => "5.0", :start => "100", :counter_length => "100")
  end
  
  def test_j_counter_ajax
    assert_equal ajax_javascript("/stats"), j_counter_runner(:ajax => "/stats")
  end

  def test_j_counter_html
    assert_equal %(<div id=\"j_counter_tick\">\n<div  class="j_counter_tick" id="tick_0">0</div>\n</div>), j_counter_html(:counter_length => 1)
  end

  def test_j_counter_html_length
    assert_equal %(<div id=\"j_counter_tick\">\n<div  class="j_counter_tick" id="tick_0">0</div>\n<div  class="j_counter_tick" id="tick_1">0</div>\n</div>), j_counter_html(:counter_length => 2)
  end

  def test_j_counter_html_length_and_name
    assert_equal %(<div id=\"j_counter_tock\">\n<div  class="j_counter_tick" id="tock_0">0</div>\n<div  class="j_counter_tick" id="tock_1">0</div>\n</div>), j_counter_html(:counter_length => 2, :counter_name => 'tock')
  end

  def test_j_counter_html_length_and_name_and_style
    assert_equal %(<div id=\"j_counter_tock\">\n<div  class="j_counter_tick clock" id="tock_0">0</div>\n<div  class="j_counter_tick clock" id="tock_1">0</div>\n</div>), j_counter_html(:counter_length => 2, :counter_name => 'tock', :counter_style => "clock")
  end
  
  private
  
  def default_javascript(slope="1.0", start="0", padding="9")
    "    <script type=\"text/javascript\" charset=\"utf-8\">\n    //<![CDATA[\n              \t\t\t$(function(){\n\n    \t\t\t\t\t\t\tjCounter({startCount : #{start}, slope : #{slope}, afterUpdateCallback: function(currentCount){\n    \t\t\t\t\t\t\t\tcount = currentCount + '';\n    \t\t\t\t\t\t\t\tcount_items = count.padWithZeros(#{padding}).split(\"\");\n    \t\t\t\t\t\t\t\tfor(i = 0; i < count_items.length; i++ ){\n    \t\t\t\t\t\t\t\t\t$(\"#tick_\"+i).html(count_items[i])\n    \t\t\t\t\t\t\t\t}\n    \t\t\t\t\t\t\t}}).countIt()\n              \t\t\t});\n\n  \t\t//]]>\n  \t\t</script>\n"
  end
  
  def ajax_javascript(url="/stats")
    "    <script type=\"text/javascript\" charset=\"utf-8\">\n    //<![CDATA[\n                    \t$(document).ready(function() {\n    \t\t\t\t$.ajax({ url: \"#{url}\", \n    \t\t\t\t\t\t success: function(data){\n\n    \t\t\t\t\t\t\tjCounter({startCount : data.startCount, slope : data.slope, afterUpdateCallback: function(currentCount){\n    \t\t\t\t\t\t\t\tcount = currentCount + '';\n    \t\t\t\t\t\t\t\tcount_items = count.padWithZeros(9).split(\"\");\n    \t\t\t\t\t\t\t\tfor(i = 0; i < count_items.length; i++ ){\n    \t\t\t\t\t\t\t\t\t$(\"#tick_\"+i).html(count_items[i])\n    \t\t\t\t\t\t\t\t}\n    \t\t\t\t\t\t\t}}).countIt()\n                    \t\t\t }\n\t\t\t\t });\n\t\t\t});\n\t\t\t\n\n  \t\t//]]>\n  \t\t</script>\n"
  end
  
end