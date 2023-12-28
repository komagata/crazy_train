require 'crazy_train'

namespace :crazy_train do
  task generate_token: :environment do
    payload = ENV.fetch('PAYLOAD', nil)
    puts CrazyTrain::JWT.encode(payload)
  end
end
