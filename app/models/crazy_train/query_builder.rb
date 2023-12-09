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
      orders = @order.split(',')
      orders.each do |order_text|
        order_text.split('.')
      end

    end

    def to_query
      @query
    end

  end
end
