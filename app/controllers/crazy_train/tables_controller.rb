module CrazyTrain
  class TablesController < ApplicationController
    def index
      puts ActiveRecord::Base.connection.execute('ECHO ROLE;')
      render json: CrazyTrain::Table.names
    end
  end
end
