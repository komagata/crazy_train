require 'test_helper'

module CrazyTrain
  class RoleTest < ActiveSupport::TestCase
    class Foo
      include CrazyTrain::Role
    end

    setup do
      @foo = Foo.new
    end

    test '#current_role' do
      expected = ENV['GITHUB_ACTIONS'] ? 'runner' : `whoami`.strip

      assert_equal expected, @foo.current_role
    end
  end
end
