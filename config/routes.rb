Rails.application.routes.draw do
  mount Rswag::Ui::Engine => '/api-docs'
  mount Rswag::Api::Engine => '/api-docs'

  get '/health', to: 'health_check#show'

  namespace :weather do
    resources :historical do
      collection do
        get '', to: 'historical#last_24_hours'
        get '/max', to: 'historical#maximum'
        get '/min', to: 'historical#minimum'
        get '/avg', to: 'historical#average'
      end
    end
  end
end
