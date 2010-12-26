module JCounter
  module Controllers
    # Those helpers are convenience methods added to ApplicationController.
    module Helpers

      extend ActiveSupport::Concern

      include JCounterHelper

      
    end
  end
end
