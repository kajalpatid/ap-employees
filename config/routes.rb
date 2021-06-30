Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  namespace :v1, defaults: {format: 'json'}, module: 'api/v1' do
    resources :employee_details do
      get :company_hierarchy, on: :collection
      get :top_salary_employees, on: :collection
      get :resign, on: :member
    end
  end
end
