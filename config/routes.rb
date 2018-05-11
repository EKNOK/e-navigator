Rails.application.routes.draw do
  devise_for :users, only: [:sign_in, :sign_out, :session, :registerations]
  as :user do
    get '/users/sign_up', to: 'devise/registrations#new', as: :new_user_registration
    post '/users', to: 'devise/registrations#create', as: :user_registration
  end
  post '/sendmail_request', to: 'interviews#sendmail_request', as: 'sendmail_request'
  resources :users, only: [:index, :edit, :update] do
    resources :interviews
  end
  if Rails.env.development?
    mount LetterOpenerWeb::Engine, at: "/letter_opener"
  end
  root to: 'users#index'
end
