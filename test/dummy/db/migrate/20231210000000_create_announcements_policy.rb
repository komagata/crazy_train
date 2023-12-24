class CreateAnnouncementsPolicy < ActiveRecord::Migration[7.1]
  def up
    execute 'ALTER TABLE announcements ENABLE ROW LEVEL SECURITY'
    execute <<~SQL.squish
      CREATE POLICY announcements_policy_for_authenticated ON announcements TO authenticated USING (TRUE)
    SQL
    execute <<~SQL.squish
      CREATE POLICY announcements_policy_for_admin
        ON announcements
        TO admin
        USING (TRUE)
        WITH CHECK (TRUE)
    SQL
  end

  def down
    execute 'ALTER TABLE announcements DISABLE ROW LEVEL SECURITY'
    execute 'DROP POLICY announcements_policy_for_authenticated ON announcements'
    execute 'DROP POLICY announcements_policy_for_admin ON announcements'
  end
end
