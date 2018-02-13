Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  namespace :api do
    namespace :v1 do
      get '/places', to: 'places#get_places'
      get '/places/:place_id', to: 'places#get_place'
      get '/pictures/:picture_id', to: 'places#get_picture'

      post '/signup', to: 'users#signup'
      post '/login', to: 'users#login'
      get '/currentuser', to: 'users#find_current_user'
    end
  end

end
