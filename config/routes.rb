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
    resources :customers
    resources :items
    patch 'customers/info/withdraw' => 'customers#withdraw', as: 'withdraw'
  end
end
