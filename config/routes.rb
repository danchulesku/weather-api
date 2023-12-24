Rails.application.routes.draw do
  get '/health', to: 'health_check#show'
end
