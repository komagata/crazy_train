class CreateUsersPolicy < ActiveRecord::Migration[7.1]
  def up
    execute 'ALTER TABLE users ENABLE ROW LEVEL SECURITY'
    execute <<~SQL.squish
      CREATE POLICY users_policy_for_admin ON users TO admin USING (TRUE)
    SQL
  end

  def down
    execute 'ALTER TABLE users DISABLE ROW LEVEL SECURITY'
    execute 'DROP POLICY users_policy_for_admin ON users'
  end
end
