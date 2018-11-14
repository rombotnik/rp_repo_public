Rails.application.routes.draw do

  root 'dashboard#index'

  devise_for :users

  authenticate :user do

    resources :stories do
      resources :scenes
      resources :notes
    end

    resources :characters do
      resources :notes
    end

    resources :genres, except: :show
    resources :ideas, except: :show
    resources :users, except: :show

    get '/stories/:story_id/scenes/:id/rp', to: 'scenes#rp', as: 'story_scene_rp'  

  end

  mount ActionCable.server => '/cable'

end
