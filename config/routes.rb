Rails.application.routes.draw do
  resources :categories, only: %i[index create destroy]
end
