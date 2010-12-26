module JCounterHelper
 
  # Create the HTML elements that will house the numbers.  T
  # 
  # Options:
  #   :counter_length, the number of digits in the counter,   defaults to 9
  #   :counter_name, the prefix name of the counter IDs in HTML, defaults to tick
  #   :counter_style, any additional styles you may want to add, defaults to nothing
  #
  # Note:
  #   Make sure to have the same counter_length and counter_name as that in the j_counter_runner helper
  # 
  # Examples:
  #
  #   <%= j_counter_html(:counter_length => 3) %>
  # 
  #   OUTPUT: 
  #   
  #   <div id="j_counter_tick">
  #   <div  class="j_counter_tick clock" id="tick_0">0</div>
  #   <div  class="j_counter_tick clock" id="tick_1">0</div>
  #   <div  class="j_counter_tick clock" id="tick_2">0</div>
  #   </div>
  #   
  #
  #   <%= j_counter_html(:counter_length => 5, :counter_name => "clocker", :counter_style => "clock") %>
  #
  #   OUTPUT:
  #
  #   <div id="j_counter_clocker">
  #   <div  class="j_counter_tick clock" id="clocker_0">0</div>
  #   <div  class="j_counter_tick clock" id="clocker_1">0</div>
  #   <div  class="j_counter_tick clock" id="clocker_2">0</div>
  #   <div  class="j_counter_tick clock" id="clocker_3">0</div>
  #   <div  class="j_counter_tick clock" id="clocker_4">0</div>
  #   </div>

  def j_counter_html(options={})
    counter_length = options[:counter_length] || 9
    counter_name = options[:counter_name] || "tick"
    counter_style = options[:counter_style] ? (" " + options[:counter_style]) : ""
    html = %(<div id="j_counter_#{counter_name}">\n)
    counter_length.times do |i|
      html << %(<div  class="j_counter_tick#{counter_style}" id="#{counter_name}_#{i}">0</div>\n)
    end
    html << "</div>"
    html.html_safe
  end

  # This creates the JavaScript that fills in the counter HMTL elements
  # 
  # Options:
  #   :counter_length, the number of digits in the counter,   defaults to 9
  #   :counter_name, the prefix name of the counter IDs in HTML, defaults to tick
  #   :period, the amount of milliseconds between updates (affects rate of increase), defaults to 1000
  #   :ajax, if specified the url to get settings for the inital settings
  #     Format of JSON response should be:
  # 
  #       {"slope":1,"startCount":9110130}
  #   :start, the starting number if ajax is not specified, defaults to 0
  #   :slope, the rate of increase if ajax is not specified, defaults to 1.0 (1 tick increment per period)
  # 
  # Usage:
  # 
  #   The two main use cases is when you either provide inline values for the start and slope values or when
  #   you use AJAX to pull them from some endpoint in your server.  Ideally you want to use the AJAX options
  #   when you are using the counter in many places and want to have some caching mechanism for your 
  #   statistics generator.  This way, you aren't necessarily hitting a database every time you pull a number.    
  #   Technically, you can probably do a caching even if you inline the numbers, but that's your preference.
  #     
  # Examples:
  #   
  #   INLINE
  # 
  #     <%= j_counter_runner(:counter_length => 5, :slope => 2.0, :start => 100) %>
  # 
  #     OUTPUT:
  # 
  #     <script type="text/javascript" charset="utf-8">
  #     //<![CDATA[
  #       $(function(){
  #         jCounter({startCount : 100, slope : 2.0 , afterUpdateCallback: function(currentCount){
  #           count = currentCount + '';
  #           count_items = count.padWithZeros(5).split("");
  #           for(i = 0; i < count_items.length; i++ ){
  #             $("#tick_"+i).html(count_items[i])
  #           }
  #         }}).countIt()
  #       });
  #     //]]>
  #     </script>
  #     
  #     AJAX
  #     
  #       j_counter_runner(:ajax => "/stats")
  #       
  #       OUTPUT
  # 
  #       <script type="text/javascript" charset="utf-8">
  #         //<![CDATA[
  #         $(document).ready(function() {
  #           $.ajax({ url: "/stats", 
  #                    success: function(data){
  #                      jCounter({startCount : data.startCount, slope : data.slope, afterUpdateCallback: function(currentCount){
  #                        count = currentCount + '';
  #                        count_items = count.padWithZeros(9).split("");
  #                        for(i = 0; i < count_items.length; i++ ){
  #                          $("#tick_"+i).html(count_items[i])
  #                        }
  #                     }}).countIt()
  #                   }
  #            });
  #         });
  #         //]]>
  #       </script>

  def j_counter_runner(options={})

    counter_name = options[:counter_name] || "tick"
    period = options[:period] || "1000" # Milliseconds
    counter_length = options[:counter_length] || 9

    if options[:ajax]
      start = "data.startCount"
      slope = "data.slope"
      start_function = <<-AJAX
      	$(document).ready(function() {
    				$.ajax({ url: "#{options[:ajax]}", 
    						 success: function(data){
      AJAX
      close_function = <<-AJAX
      			 }
				 });
			});
			
      AJAX
    else
      start = options[:start] || "0"
      slope = options[:slope] || "1.0"
      start_function = <<-AJAX
			$(function(){
      AJAX
      close_function = <<-AJAX
			});
      AJAX
    end

    javascript = <<-JAVASCRIPT
    <script type="text/javascript" charset="utf-8">
    //<![CDATA[
              #{start_function}
    							jCounter({startCount : #{start}, slope : #{slope}, afterUpdateCallback: function(currentCount){
    								count = currentCount + '';
    								count_items = count.padWithZeros(#{counter_length}).split("");
    								for(i = 0; i < count_items.length; i++ ){
    									$("##{counter_name}_"+i).html(count_items[i])
    								}
    							}}).countIt()
              #{close_function}
  		//]]>
  		</script>
      JAVASCRIPT
    javascript.html_safe
  end
 
end