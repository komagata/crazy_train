require 'api_error_handler'

module CrazyTrain
  class Engine < ::Rails::Engine
    isolate_namespace CrazyTrain
  end
end
