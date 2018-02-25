Rails.application.routes.draw do

  resources :mediafiles

  resources :items

  resources :collections

  resources :museums

  namespace :system do
    resources :help_categories
  end

  namespace :system do
    resources :helps
  end

  namespace :example do
    resources :posts do
        collection do
            get 'report'
        end
    end
    resources :lab
    resources :tags do
      collection do
          get 'getSearch'
          get 'report'
      end
    end
    resources :categories do
      collection do
          get 'getSearch'
          get 'report'
      end
    end
    resources :post_tags do
      collection do
          get 'list'
          get 'insert'
      end
    end
  end

  namespace :system do
    resources :vouchers
    resources :configs
    resources :updater
    resources :about
    resources :bugs
    resources :access_tos
    resources :bug_messages
    resources :bug_statuses
    resources :help
    resources :programs do
      collection do
          get 'getSearch'
      end
    end
    resources :files
    resources :developer
    resources :category_programs
    resources :access_to_nested_resources
    resources :group_accesses do
      collection do
          get 'getSearch'
      end
    end
    resources :group_access_people do
      collection do
          get 'list'
          get 'insert'
          get 'listProgramsByUser'
      end
    end
    resources :group_access_programs do
      collection do
          get 'list'
          get 'insert'
      end
    end
    resources :central do
		    collection do
            get 'notifications'
            get 'setLocate'
        end
    end
  end
    
  resources :accounts, :as => "users" do
    collection do
      get 'become'
    end
  end

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  resources :dashboard

  devise_for :users, controllers: { sessions: "users/sessions", registrations: "users/registrations", passwords: "users/passwords",:omniauth_callbacks => "users/omniauth_callbacks", confirmations: "users/confirmations" }

  resources :system, controllers:{ accounts:"system/account"}

  # You can have the root of your site routed with "root"
  root 'public/site#index'

  get 'forbidden' => 'public/site#forbidden'
  get 'without_permissions' => 'public/site#without_permissions'
  get 'help/' => 'public/help#index'
  get 'ajuda/' => 'public/help#index'
  get 'voucher' => 'public/voucher#index'

  namespace :public do
    resources :voucher do
        collection do
          post 'account'
      end
    end
    resources :policy do
      collection do
        get 'terms'
        get 'privacy'
      end
    end
    resources :api do
      collection do
        get 'isOnAir'
        get 'create'
        get 'checkToken'
        get 'getBasicInformation'
        get 'about'
        post 'setFile'
      end
    end
    resources :vouchers
  end
    
  #custom your routes
  eval(File.read('config/custom_routes.rb'))
end
