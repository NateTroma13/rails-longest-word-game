Rails.application.routes.draw do
  get 'games/new', to: 'games#new', as: 'new_game'
  post 'score', to: 'games#score', as: 'score'
  get 'games/result', to: 'games#result', as: 'result_game'

  root 'games#new'
end
