CrazyTrain::Engine.routes.draw do
  get 'tables' => 'tables#index', as: :tables
  get ':resource' => 'resources#index'
  get ':resource/:id' => 'resources#show'
end
