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

  def self.setup_jwt_claims!(paylaod)
    ActiveRecord::Base.connection.execute("SET request.jwt.claims = '#{paylaod}'")
  end

  def self.request_jwt_claims
    sql = "SELECT current_setting('request.jwt.claims', true) AS request_jwt_claims"
    string = ActiveRecord::Base.connection.execute(sql).to_a.first['request_jwt_claims']
    JSON.parse(string)
  end
end
