Rails.application.routes.draw do
  resources :announcements
  resources :notes
  resources :users
  mount CrazyTrain::Engine => '/crazy_train'
end
