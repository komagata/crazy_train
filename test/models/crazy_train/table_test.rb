require 'test_helper'

module CrazyTrain
  class TableTest < ActiveSupport::TestCase
    test '.names' do
      assert_equal %w[announcements users notes], CrazyTrain::Table.names
    end
  end
end
