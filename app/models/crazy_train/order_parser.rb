module CrazyTrain
  class OrderParser
    attr_reader :orders

    def initialize(order_text)
      @order_text = order_text
      @orders = {}
    end

    def parse!
      @order_text.split(',').map do |text|
        name, direction = text.split('.')
        direction ||= 'asc'
        @orders[name] = direction
      end
    end
  end
end
