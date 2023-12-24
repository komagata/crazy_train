module CrazyTrain
  class Grant
    class << self
      def execute!
        sql "GRANT SELECT ON announcements TO #{CrazyTrain.config.unauthorized_role}"
        sql "GRANT SELECT ON announcements TO #{CrazyTrain.config.authenticated_role}"
        sql 'GRANT ALL PRIVILEGES ON announcements TO admin'
        sql 'GRANT ALL PRIVILEGES ON users TO admin'
        sql 'GRANT ALL PRIVILEGES ON notes TO admin'
        sql 'GRANT USAGE ON announcements_id_seq TO admin'
      end

      def sql(statement)
        ActiveRecord::Base.connection.execute(statement)
      end
    end
  end
end
