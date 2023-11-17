Rails.application.routes.draw do
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
  end
  get 'customers/mypage' => 'public/customers#show', as: 'mypage'
  # namespace :public do
  # end
end
