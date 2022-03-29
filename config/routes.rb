Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root to: 'kody_pocztowe#new'
  get 'write1', to: 'kody_pocztowe#write1'
  get 'write2', to: 'kody_pocztowe#write2'
  get 'write3', to: 'kody_pocztowe#write3'
end
