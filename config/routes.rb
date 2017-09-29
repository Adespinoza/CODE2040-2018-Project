Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  root to: 'home#index'
  get 'about', to: 'home#about'
  get '2', to: 'home#mod_2'
  get '3', to: 'home#mod_3'
  get '4', to: 'home#mod_4'
  get '5', to: 'home#mod_5'


  get 'data/spell-freq', to: 'data#spell_freq', defaults: { format: 'json' }
  get 'data/book-freq', to: 'data#book_freq', defaults: { format: 'json' }
  get 'data/spell-def-sent', to: 'data#spell_def_sent', defaults: { format: 'json' }
  get 'data/spell-in-men-sent', to: 'data#spell_in_men_sent', defaults: { format: 'json' }
  get 'data/book-sent', to: 'data#book_sent', defaults: { format: 'json' }
  get 'data/pos-sent', to: 'data#pos_men_sent', defaults: { format: 'json' }

  get 'reverse', to: 'reverse#show'
  post 'reverse/validate'

  get 'counter', to: 'counter#show'
  post 'counter/validate'

  get 'letter', to: 'letter#show'
  post 'letter/validate'

  get 'lookup', to: 'lookup#show'
  post 'lookup/validate'

  get 'freestyle', to: 'freestyle#show'
  post 'freestyle/validate'

  get 'spellchecker', to: 'spellchecker#show'

end
