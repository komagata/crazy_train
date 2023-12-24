class CreateRoles < ActiveRecord::Migration[7.1]
  def up
    execute <<~SQL.squish
      DO $$
      BEGIN
          IF NOT EXISTS (SELECT FROM pg_roles WHERE rolname = 'anonymous') THEN
              CREATE ROLE anonymous;
          END IF;
      END
      $$;
    SQL

    execute <<~SQL.squish
      DO $$
      BEGIN
          IF NOT EXISTS (SELECT FROM pg_roles WHERE rolname = 'authenticated') THEN
              CREATE ROLE authenticated;
          END IF;
      END
      $$;
    SQL

    execute <<~SQL.squish
      DO $$
      BEGIN
          IF NOT EXISTS (SELECT FROM pg_roles WHERE rolname = 'admin') THEN
              CREATE ROLE admin;
          END IF;
      END
      $$;
    SQL
  end

  def down
    execute <<~SQL.squish
      DO $$
      BEGIN
          IF EXISTS (SELECT FROM pg_roles WHERE rolname = 'anonymous') THEN
              DROP ROLE anonymous;
          END IF;
      END
      $$;
    SQL

    execute <<~SQL.squish
      DO $$
      BEGIN
          IF EXISTS (SELECT FROM pg_roles WHERE rolname = 'authenticated') THEN
              DROP ROLE authenticated;
          END IF;
      END
      $$;
    SQL

    execute <<~SQL.squish
      DO $$
      BEGIN
          IF EXISTS (SELECT FROM pg_roles WHERE rolname = 'admin') THEN
              DROP ROLE admin;
          END IF;
      END
      $$;
    SQL
  end
end
