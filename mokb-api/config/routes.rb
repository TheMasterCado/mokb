Rails.application.routes.draw do
  resource :auth, only: [], controller: :auth do
    post 'token'
    delete 'token', to: 'destroy'
  end
end
