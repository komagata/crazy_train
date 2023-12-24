require 'crazy_train/version'
require 'crazy_train/engine'
require 'crazy_train/jwt'
require 'jwt'

module CrazyTrain
  Config = Struct.new(:secret, :unauthorized_role, :authenticated_role)
  @@config = Config.new(
    secret: 'you-must-change-this',
    unauthorized_role: 'anonymous',
    authenticated_role: 'authenticated'
  )

  def self.config
    @@config
  end

  def self.setup
    yield @@config
  end

  def self.current_role
    ActiveRecord::Base.connection.execute('SELECT current_user').to_a.first['current_user']
  end

  def self.current_settings
    ActiveRecord::Base.connection.execute('SELECT current_setting').to_a.first['current_setting']
  end

  def self.set_db_config(key, value)
    ActiveRecord::Base.connection.execute("SELECT set_config('#{key}', '#{value}', true)")
  end

  def self.set_jwt_claims
    ActiveRecord::Base.connection.execute("SELECT set_config('request.jwt.claims', '#{value}', true)")
  end
end
