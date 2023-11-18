module CrazyTrain
  class ResourcesController < ApplicationController
    def index
      resources = klass.all
      render json: resources
    end

    def show
      resource = klass.find(params[:id])
      render json: resource
    end

    private

    def klass
      name = params[:resource].singularize
      CrazyTrain::Table.klass(name)
    end
  end
end
