Rails.application.routes.draw do
  get '/items' ,to: 'items#index'
  #resourses: :items
end
