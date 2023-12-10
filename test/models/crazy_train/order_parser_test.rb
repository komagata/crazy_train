require 'test_helper'

module CrazyTrain
  class OrderParserTest < ActiveSupport::TestCase
    test '#parser!' do
      order_parser = CrazyTrain::OrderParser.new('name.asc,id.desc')
      order_parser.parse!

      expected = {
        'name' => 'asc',
        'id' => 'desc'
      }

      assert_equal expected, order_parser.orders
    end

    test '#parser! with no order' do
      order_parser = CrazyTrain::OrderParser.new('name,id')
      order_parser.parse!

      expected = {
        'name' => 'asc',
        'id' => 'asc'
      }

      assert_equal expected, order_parser.orders
    end

    test '#parser! with blank order' do
      order_parser = CrazyTrain::OrderParser.new('')
      order_parser.parse!

      assert_empty order_parser.orders
    end
  end
end
