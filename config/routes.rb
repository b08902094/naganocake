Rails.application.routes.draw do
  get 'customers/confirm' => 'public/customers#confirm', as: 'confirm'
  # 顧客用
  # URL /customers/sign_in ...
  devise_for :customers, skip: [:passwords], controllers: {
    registrations: "public/registrations",
    sessions: 'public/sessions'
  }
  # 管理者用
  # URL /admin/sign_in ...
  devise_for :admin, skip: [:registrations, :passwords] ,controllers: {
    sessions: "admin/sessions"
  }
  get '/admin', to: 'admin/homes#top'
  root to: 'public/homes#top'
  namespace :admin do
      resources :items
      resources :genres
      resources :customers
  end
  get 'customers/mypage' => 'public/customers#show', as: 'mypage'

  scope module: :public do
    delete 'cart_items/destroy_all' => 'cart_items#destroy_all', as: 'destroy_all_cart_items'
    resources :customers
    resources :items do
      resources :cart_items, only: [:create, :update, :destroy]
    end
    resources :cart_items, only: [:index]
    patch 'customers/info/withdraw' => 'customers#withdraw', as: 'withdraw'
  end
end
