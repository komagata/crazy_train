module CrazyTrain
  class Table
    SYSTEM_TABLES = %w[ar_internal_metadata schema_migrations].freeze

    class << self
      def names
        ActiveRecord::Base.connection.tables - SYSTEM_TABLES
      end

      def classes
        names.map { |name| name.classify.constantize }
      end

      def klass(name)
        name.classify.constantize
      end
    end
  end
end
