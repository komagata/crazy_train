module CrazyTrain
  class QueryBuilder
    def initialize(
      klass,
      order: nil
    )
      @klass = klass
      @order = order
    end

    def parse!
      @query = klass.all

      @order_parser = CrazyTrain::OrderParser.new(order)
      @order_parser.parse!
    end

    def to_query
      @query
    end
  end
end
