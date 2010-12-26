require 'open-uri'


module JCounter

    class InstallGenerator < Rails::Generators::Base
      source_root File.expand_path('../templates', __FILE__)
    
      desc "Copy over JavaScript and CSS files"

      def copy_javascript
        # copy_file "jcounter.js", "public/javascripts/jcounter.js"

        # Thor Actions for future reference, took me a while to figure out how to do some simple stuff
        if yes?("Would you like to install latest JS from github")
          get "https://github.com/jamster/jCounter/raw/master/javascripts/counter.js", "public/javascripts/jcounter.js"
        else
          copy_file "jcounter.js", "public/javascripts/jcounter.js"
        end
        

        ##  More thor actions, maybe use later
        # create_file "public/javascripts/jcounter.js", data
        # inject_into_file "public/javascripts/jcounter.js", data
        # chmod "#{file}.log", 0666, :verbose => false        
        # copy_file "jcounter.js", "public/javascripts/jcounter.js"
        
      end

      def copy_css
        if yes?("Would you like to install latest JS from github")
          get "https://github.com/jamster/jCounter/raw/master/stylesheets/jcounter.css", "public/javascripts/jcounter.css"
        else
          copy_file "jcounter.css", "public/stylesheets/jcounter.css"
        end
      end
      
      def show_readme
        readme "README" if behavior == :invoke
      end

    end

end