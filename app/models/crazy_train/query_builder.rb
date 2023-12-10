module CrazyTrain
  class QueryBuilder
    attr_reader :klass, :params, :query, :orders

    def initialize(klass, params)
      @klass = klass
      @params = params
      @query = nil
      @orders = []
    end

    def parse!
      @query = klass.all

      return unless params[:order]

      @order_parser = CrazyTrain::OrderParser.new(params[:order])
      @order_parser.parse!
      @orders = @order_parser.orders
      @query = @query.order(@orders)

      # if params[:select]
      # end
    end
  end
end
