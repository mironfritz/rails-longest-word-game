Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  get '/get_input', to: 'pages#get_input'
  post '/show_result', to: 'pages#show_result'
end
