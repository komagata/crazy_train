require 'crazy_train'

namespace :crazy_train do
  task generate_token: :environment do
    puts CrazyTrain::JWT.generate_token(ENV.fetch('PAYLOAD', nil))
  end
end
