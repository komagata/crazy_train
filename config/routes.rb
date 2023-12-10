CrazyTrain::Engine.routes.draw do
  get 'tables' => 'tables#index', as: :tables, format: :json
  get ':resource' => 'resources#index', as: :resources, format: :json
  get ':resource/:id' => 'resources#show', as: :resource, format: :json
end
