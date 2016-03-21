Rails.application.routes.draw do
  mount Judge::Engine => '/judge'

  get 'home' => 'home#index', as: 'home'

  # employee
  get 'employees' => 'users#employees', as: 'employees'
  get 'employees/:id' => 'users#show_employee', as: 'show_employee'

  # employee options
  get 'employees/:employee_id/new_client' => 'clients#new', as: 'employee_new_client'
  get 'employees/:employee_id/client/:id' => 'clients#show', as: 'show_through_employee'

  # root 'users#index'

  # logging and logging out
  root 'sessions#new'
  get 'login' => 'sessions#new', as: 'login'
  post 'login' => 'sessions#create', as: 'check_login'
  get 'logout' => 'sessions#destroy', as: 'logout'

  resources :users

  resources :clients do
    resources :transactions do

    end
  end

  # password_related
  get 'users/:id/change_password' => 'users#change_password', as: 'change_password'
  patch 'users/:id/change_password' => 'users#update_password'
  put 'users/:id/change_password' => 'users#update_password'



  # get 'clients/:id/new_transaction' => 'transactions#new', as: 'new_transaction'
  # get 'clients/:id/transactions/:transaction_id/full_payment' => 'transactions#full_payment', as: 'transaction_fullpayment'
  # get 'clients/:id/transactions/:transaction_id/edit' => 'transactions#edit', as: 'edit_transaction'
  # get 'clients/:id/transactions/:transaction_id/new_payment' => 'provisional_receipts#new', as: 'new_provisional_receipts'
  # get 'clients/:id/transactions/:transaction_id/edit/:provisional_receipt_id' => 'provisional_receipts#edit', as: 'edit_provisional_receipts'
  # get 'clients/:id/transactions/:transaction_id' => 'transactions#show', as: 'transaction'

  post ':id/fees/new' => 'fees#create', as:'new_fee'

  get 'reports/services_report' => 'reports#services_report', as: "reports_services_report"

  patch 'clients/:id/transactions/:transaction_id/edit/:provisional_receipt_id' => 'provisional_receipts#update', as: "edit_provisional_receipts"

  get 'reports/accounts_receivable'

  get 'reports/employees_report'

  get 'reports/transactions_report'

  resources :reports

  resources :transactions

  resources :fees

  resources :services

  resources :provisional_receipts
end
