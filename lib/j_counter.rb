# Jcounter

%w{ models controllers helpers }.each do |dir|
  path = File.join(File.dirname(__FILE__), 'app', dir)
  $LOAD_PATH << path
  ActiveSupport::Dependencies.autoload_paths << path
  ActiveSupport::Dependencies.autoload_once_paths.delete(path)
end

module JCounter
  module Controllers
    autoload :Helpers, 'j_counter/controllers/helpers'
  end
end

ActiveSupport.on_load(:action_controller) do
  include JCounter::Controllers::Helpers
end

ActiveSupport.on_load(:action_view) do
  include JCounter::Controllers::Helpers
end
