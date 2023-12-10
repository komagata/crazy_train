require 'crazy_train/version'
require 'crazy_train/engine'
require 'crazy_train/jwt'
require 'jwt'

module CrazyTrain
  Config = Struct.new(:secret)
  @@config = Config.new

  def self.config
    @@config
  end

  def self.setup
    yield @@config
  end
end
