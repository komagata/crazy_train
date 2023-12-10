module CrazyTrain
  class ResourcesController < ApplicationController
    def index
      query_builder = CrazyTrain::QueryBuilder.new(klass, params)
      query_builder.parse!

      records = query_builder.query
      render json: records
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
