Rails.application.routes.draw do
  get 'reports/accounts_receivable'

  get 'reports/employees_report'

  get 'reports/transactions_report'

  mount Judge::Engine => '/judge'

  get 'login' => 'sessions#new', as: 'login'

  post 'login' => 'sessions#create', as: 'check_login'

  get 'logout' => 'sessions#destroy', as: 'logout'

  get 'employees' => 'users#employees', as: 'employees'

  get 'employees/:id' => 'users#show_employee', as: 'show_employee'

  get 'employees/:id/new-client' => 'clients#new', as: 'employee_new_client'

  get 'home' => 'home#index', as: 'home'

  # root 'users#index'
  root 'sessions#new'

  get 'users/:id/clients' => 'users#clients'

  resources :users

  get 'clients/assign'

  resources :clients

  get 'users/:id/change_password' => 'users#change_password', as: 'change_password'

  patch 'users/:id/change_password' => 'users#update_password'

  put 'users/:id/change_password' => 'users#update_password'

  get 'clients/:id/new_transaction' => 'transactions#new', as: 'new_transaction'

  get 'clients/:id/transactions/:transaction_id/full_payment' => 'transactions#full_payment', as: 'transaction_fullpayment'

  post ':id/fees/new' => 'fees#create', as:'new_fee'

  get 'clients/:id/transactions/:transaction_id/new_payment' => 'provisional_receipts#new', as: 'new_provisional_receipts'

  get 'clients/:id/transactions/:transaction_id/edit/:provisional_receipt_id' => 'provisional_receipts#edit', as: 'edit_provisional_receipts'

  get 'clients/:id/transactions/:transaction_id' => 'transactions#show', as: 'transaction'

  resources :reports

  resources :transactions

  resources :fees

  resources :services

  resources :provisional_receipts

  # Hi! I'm anpeng and I'll put some references here. :D
  # get '/patients/:id', to: 'patients#show', as: 'patient'
  # <%= link_to 'Patient Record', patient_path(@patient) %>

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  # root 'welcome#index'

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Example resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Example resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Example resource route with more complex sub-resources:
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', on: :collection
  #     end
  #   end

  # Example resource route with concerns:
  #   concern :toggleable do
  #     post 'toggle'
  #   end
  #   resources :posts, concerns: :toggleable
  #   resources :photos, concerns: :toggleable

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end
end
