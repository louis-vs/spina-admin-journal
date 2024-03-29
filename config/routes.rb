# frozen_string_literal: true

Spina::Engine.routes.draw do
  namespace :admin, path: Spina.config.backend_path do
    namespace :journal do
      resources :journals, only: %i[edit update destroy]
      resources :volumes, except: %i[show update] do
        post 'sort/:journal_id' => 'volumes#sort', as: :sort, on: :collection

        member do
          get :view_issues
        end
      end
      resources :issues, except: %i[show] do
        post 'sort/:volume_id' => 'issues#sort', as: :sort, on: :collection

        member do
          get :view_articles
        end
      end
      resources :articles, except: %i[show] do
        post 'sort/:issue_id' => 'articles#sort', as: :sort, on: :collection

        member do
          get :view_authors
        end
      end
      resources :authors, except: %i[show] do
        post 'sort/:article_id' => 'authors#sort', as: :sort, on: :collection

        member do
          get :view_articles
        end
      end

      resources :institutions, except: %i[show] do
        member do
          get :view_affiliations
        end
      end
      resources :licences, except: %i[show]
    end
  end
end
