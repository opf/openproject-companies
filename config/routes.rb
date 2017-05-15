OpenProject::Application.routes.draw do
  resources :companies do
    member do
      get :filter_available_members
      get :filter_available_projects

      post 'delete_member/:member_id', to: 'companies#delete_member', as: 'delete_member'
      post :add_members

      post 'delete_project/:project_id', to: 'companies#delete_project', as: 'delete_project'
      post :add_projects
    end
  end
end
