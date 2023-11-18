CrazyTrain::Engine.routes.draw do
  get 'tables' => 'tables#index'
  get ':resource' => 'resources#index'
  get ':resource/:id' => 'resources#show'
end
