Rails.application.routes.draw do
  resources :categories, only: %i[index create edit update destroy]
end
