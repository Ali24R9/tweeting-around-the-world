Rails.application.routes.draw do
  get 'sessions/new'

  get 'sessions/create'

  get 'sessions/failure'

 root to: "home#index"


 #locations
 get 'twitter/get_tweet', :to => 'twitter#get_tweet'

end
