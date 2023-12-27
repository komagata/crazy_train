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
      user = `whoami`.strip
      @foo.switch_role(user)

      assert_equal user, @foo.current_role
    end
  end
end
