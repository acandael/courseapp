Courseapp::Application.routes.draw do
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
  root to: "pages#front"
  get 'ui(/:action)', controller: 'ui'
  get 'pages/subscription_plans', controller: 'pages'
  get 'register', to: "users#new"
  get 'sign_in', to: 'sessions#new'
  get 'sign_out', to: 'sessions#destroy'
  get 'home', to: 'courses#index'
  get 'courses/:id/chapters/:chapter_id/video/:video_id', controller: 'chapters', action: 'show', as: 'show_video'
 
  get 'quizzes/:id/question/:question_id', controller: 'quizzes', action: 'show', as: 'show_question'
  get 'quizzes/:id/quiz_success', controller: 'quizzes', action: 'complete', as: 'quiz_complete' 
  post 'answer/:id', controller: 'answers', action: 'check_answer', as: 'check_answer'
  resources :courses, only: [:show] do
    resources :chapters, only: [:show]
  end

  resources :chapters, only: [:show] do
    resources :quizzes, only: [:show]
  end

  resources :quizzes, only: [:show] do
  end

  resources :questions, only: [:show] do
  end

  resources :users, only: [:create]
  resources :sessions, only: [:create]
  
  namespace :admin do
    resources :courses do
      resources :chapters
    end
  end

  namespace :admin do
    resources :chapters do
      resources :videos
    end
  end

  end
