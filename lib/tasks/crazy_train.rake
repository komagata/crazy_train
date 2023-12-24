namespace :crazy_train do
  task generate_token: :environment do
    puts CrazyTrain::JWT.encode(
      {
        'iss' => 'crazy_train',
        'user_id' => 1234
      },
      CrazyTrain.config.secret
    )
  end
end
