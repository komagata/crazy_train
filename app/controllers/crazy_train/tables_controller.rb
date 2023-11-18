module CrazyTrain
  class TablesController < ApplicationController
    def index
      render json: CrazyTrain::Table.names
    end
  end
end
