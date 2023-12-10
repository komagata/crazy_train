module CrazyTrain
  class ResourcesController < ApplicationController
    def index
      query_builder = CrazyTrain::QueryBuilder.new(klass, params)
      query_builder.parse!

      render json: query_builder.query
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
