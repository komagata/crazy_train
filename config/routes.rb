CrazyTrain::Engine.routes.draw do
  get 'tables' => 'tables#index', as: :tables, format: :json
  get ':resource' => 'resources#index', as: :resources, format: :json
  get ':resource/:id' => 'resources#show', as: :resource, format: :json
  post ':resource' => 'resources#create', format: :json
  patch ':resource/:id' => 'resources#update', format: :json
  delete ':resource/:id' => 'resources#destroy', format: :json
end
