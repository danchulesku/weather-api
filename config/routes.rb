Rails.application.routes.draw do
  mount Rswag::Ui::Engine => '/api-docs'
  mount Rswag::Api::Engine => '/api-docs'

  get '/health', to: 'health_check#show'

  namespace :weather do
    resource :historical, only: %i[]  do
      collection do
        get '', to: 'historical#last_24_hours'
        get '/max', to: 'historical#maximum'
        get '/min', to: 'historical#minimum'
        get '/avg', to: 'historical#average'
      end
    end
  end

  resource :weather, only: %i[] do
    collection do
      get '/current', to: 'weather#current'
      get '/by_time', to: 'weather#by_time'
    end
  end
end
