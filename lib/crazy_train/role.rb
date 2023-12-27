module CrazyTrain
  module Role
    def current_role
      ActiveRecord::Base.connection.execute('SELECT current_user').to_a.first['current_user']
    end

    def switch_role(role)
      ActiveRecord::Base.connection.execute("SET ROLE #{role}")
    end
  end
end
