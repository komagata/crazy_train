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

    end

    def parse_order!
      @order.split(',')

    end

    def to_query
      @query
    end

  end
end
