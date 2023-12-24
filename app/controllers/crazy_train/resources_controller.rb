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

    def create
      klass.create!(resource_params.to_h)

      head :created
    end

    def update
      resource = klass.find(params[:id])
      resource.update!(resource_params.to_h)

      head :no_content
    end

    def destroy
      resource = klass.find(params[:id])
      resource.destroy!

      head :no_content
    end

    private

    def klass
      name = params[:resource].singularize
      CrazyTrain::Table.klass(name)
    end

    def resource_params
      params.permit(*klass.column_names)
    end
  end
end
