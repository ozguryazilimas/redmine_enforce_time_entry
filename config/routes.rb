
RedmineApp::Application.routes.draw do

  resources :projects do
    member do
      match 'ete_project_settings', :via => [:get, :post]
    end
  end

end

