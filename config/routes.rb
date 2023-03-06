Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  root 'application#index'

  get '/test', to: 'questions#test'

  scope '/api' do 
    get '/database', to: 'questions#index'
    get '/questions/:id', to: 'questions#show'
    post '/questions', to: 'questions#create'
    post '/questions/like', to: 'questions#like'
    post '/questions/dislike', to: 'questions#dislike'
    post '/questions/feedback', to: 'questions#feedback'
  end
end
