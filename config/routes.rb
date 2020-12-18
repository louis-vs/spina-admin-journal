# frozen_string_literal: true

Spina::Engine.routes.draw do
  namespace :admin, path: Spina.config.backend_path do
    namespace :journal do
      resources :journals, except: [:show] do
        resources :volumes, except: [:show]
        resources :issues, except: [:show]
        resources :articles, except: [:show]
      end

      resources :institutions, except: [:show]
      resources :authors, except: [:show]
    end
  end
end
