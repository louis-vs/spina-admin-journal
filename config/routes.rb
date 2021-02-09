# frozen_string_literal: true

Spina::Engine.routes.draw do
  namespace :admin, path: Spina.config.backend_path do
    namespace :journal do
      resources :journals, only: %i[edit update destroy]
      resources :volumes, except: %i[show new update] do
        patch :sort, on: :collection
      end
      resources :issues, except: %i[show] do
        patch 'sort/:volume_id' => 'issues#sort', as: :sort, on: :collection
      end
      resources :articles, except: %i[show]

      resources :institutions, except: %i[show]
      resources :authors, except: %i[show]
    end
  end
end
