require 'rails/generators'

module CrazyTrain
  module Generators
    class InstallGenerator < Rails::Generators::Base
      source_root File.expand_path('templates', __dir__)

      def copy_initializer
        template 'initializer_template.erb', 'config/initializers/crazy_train.rb'
      end

      def add_route
        route "mount CrazyTrain::Engine, at: '/api'"
      end
    end
  end
end
