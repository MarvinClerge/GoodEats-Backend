Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  namespace :api do
    namespace :v1 do
      get '/places', to: 'places#get_places'
      get '/places/x', to: 'places#get_place'
    end
  end

end
