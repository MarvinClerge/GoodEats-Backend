Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  namespace :api do
    namespace :v1 do
      post '/users', to: 'users#create'
      post '/login', to: 'users#login'

      get '/places', to: 'places#get_places'
      get '/places/:place_id', to: 'places#get_place'
      get '/pictures/:picture_id', to: 'places#get_picture'

      get '/currentuser', to: 'users#find_current_user'

      delete '/removefavorite', to: 'favorites#remove_favorite'
      post '/addfavorite', to: 'favorites#add_favorite'
    end
  end

end
