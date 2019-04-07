Rails.application.routes.draw do
  resource :auth, only: [], controller: :auth do
    post 'token'
    post 'destroy'
  end
end
