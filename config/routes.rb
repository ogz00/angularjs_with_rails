Rails.application.routes.draw do


  resources :tabled_user_scores
  resources :user_scores
  root to: 'application#angular'

  scope 'api' do
    devise_for :users, controllers: {sessions: 'users/sessions'}, defaults: {format: :json}
    get 'puzzles/current', defaults: {format: :json}
    put 'puzzles/update/:id' =>'puzzles#update', defaults: {format: :json}
    patch 'puzzles/calculate/:id' => 'puzzles#calculate_and_save_score', defaults: {format: :json}
    patch 'puzzles/calculateAll' => 'puzzles#calculate_and_update_all_scores', defaults: {format: :json}

    get 'comments/current', defaults: {format: :json}
    get 'comments/admin', defaults: {format: :json}
    get 'votes/current', defaults: {format: :json}
    get 'votes/getPopularities' => 'votes#get_popularities', defaults: {format: :json}

    put 'answers/update/:id' =>'answers#update', defaults: {format: :json}
    get 'answers/getUserAnswer/:puzzle_id' => 'answers#get_user_answer', defaults: {format: :json}
    get 'user_scores/calculateScores' => 'user_scores#calculate_scores', defaults: {format: :json}
    post 'user_scores/calculateTabledScores' => 'user_scores#calculate_tabled_scores', defaults: {format: :json}

    resources :votes, defaults: {format: :json}
    resources :comments, defaults: {format: :json}
    resources :answers, defaults: {format: :json}
    resources :puzzles, defaults: {format: :json}
    resources :tabled_user_scores, defaults: {format: :json}

  end

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
#     #     resources :sales do
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
