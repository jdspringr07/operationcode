# frozen_string_literal: true
Rails.application.routes.draw do
  devise_for :veterans, controllers: { registrations: 'veterans/registrations', sessions: 'veterans/sessions' }
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)

  devise_scope :veteran do
    get :sign_up, to: 'veterans/registrations#new'
    get :join, to: 'veterans/registrations#new'
    get :login, to: 'veterans/sessions#new'
    get :sign_in, to: 'veterans/sessions#new'

    get 'profile/edit', to: 'veterans/registrations#edit'
  end

  # Split
  mount Split::Dashboard, at: 'split'

  # LetsEncrypt
  get '.well-known/acme-challenge/:token', to: 'pages#ssl'

  get '/veterans/map', to: 'veterans#map'
  resources :veterans, only: [:new, :create]
  post '/veterans/claim/:veteran', to: 'veterans#claim', as: :veterans_claim
  post '/veterans/unclaim/:veteran', to: 'veterans#unclaim', as: :veterans_unclaim

  resources :donations, only: [:index, :new, :create]

  # Profile
  get '/profile', to: 'profile#home'
  get '/profile/mentees', to: 'profile#mentees'
  get '/profile/mentees/:mentee', to: 'profile/mentees#show', as: :profile_mentee
  post '/profile/mentees/:mentee/welcome', to: 'profile/mentees#welcome', as: :welcome_mentee
  get '/profile/edit/bio', to: 'profile#edit_bio'
  post '/profile/edit/bio', to: 'profile#update_bio'
  patch '/profile/edit/bio', to: 'profile#update_bio'
  # End Profile

  # Static pages
  get '/code_schools', to: 'code_schools#index'

  get 'about' => 'pages#about'
  get 'amazon' => redirect('https://smile.amazon.com/ch/47-4247572')
  get 'deploy' => 'pages#deploy'
  get 'dwolla' => redirect('https://www.dwolla.com')
  get 'board' => 'pages#board'
  get 'contact' => 'pages#contact'
  get 'cottonbureau' => redirect('https://cottonbureau.com/products/operation-code-medal')
  get 'calendar' => 'pages#calendar'
  get 'sponsors' => 'pages#sponsors'
  get 'employers' => 'pages#employers'
  get 'events' => 'pages#events'
  get 'faq' => 'pages#faq'
  get 'founder' => 'pages#founder'
  get 'hackathons' => 'pages#hackathons'
  get 'history' => 'pages#history'
  get 'jsguide' => 'pages#jsguide'
  get 'online' => 'pages#online'
  get 'media' => 'pages#media'
  get 'mentorship' => 'pages#mentorship'
  get 'mission' => 'pages#mission'
  get 'newgibill' => 'pages#newgibill'
  get 'military_veterans_technical_talent_pipeline' => 'pages#military_veterans_technical_talent_pipeline'
  get 'press' => 'pages#press'
  get 'privacy' => 'pages#privacy'
  get 'scholarships' => 'pages#scholarships'
  get 'square' => redirect('https://cash.me/$operationcode')
  get 'speakerrequest' => 'pages#speakerrequest'
  get 'staff' => 'pages#staff'
  get 'success_stories' => 'pages#success_stories'
  get 'action' => 'veterans#new'
  get 'fellowships' => 'pages#fellowships'
  get '/contact' => redirect('mailto:david@operationcode.org')
  get '/flatiron' => redirect('https://learn.co/learn-together')
  get '/launchparty' => redirect('http://www.eventbrite.com/e/operation-code-launch-party-tickets-16494832488')
  get '/donate' => redirect('/donations/new')
  get '/learn' => redirect('/online')
  get '/contribute' => redirect('https://github.com/OperationCode/operationcode/blob/master/CONTRIBUTING.md')
  get '/news' => redirect('/newgibill')

  # /blog is still being served by jekyll
  get '/blog' => redirect('https://medium.com/operation-code')

  root 'pages#home'
end
