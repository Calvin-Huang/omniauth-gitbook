# omniauth-gitbook ![](https://travis-ci.org/Calvin-Huang/omniauth-gitbook.svg?branch=master) ![gem](https://img.shields.io/badge/gem-1.0.0-red.svg)
Gitbook Oauth2 strategy for Omniauth.
 
 ## Usage - OmniAuth
 If you only integrate OmniAuth to your project, follows to [OmniAuth offical document](https://github.com/omniauth/omniauth), you have to add callback route and have a controller to handle data from oauth exchange.
 
 Before all, add configuration for omniauth-gotbook at `config/initializers/omniauth.rb`.
 ```ruby
 Rails.application.config.middleware.use OmniAuth::Builder do
   provider :developer unless Rails.env.production?
   provider :gitbook, ENV['CLIENT_ID'], ENV['CLIENT_SECRET']
 end
 ```
 
 Add callback route to `route.rb`.
 ```ruby
 get '/auth/:provider/callback', to: 'sessions#create'
 ```
 
 Handle json data in controller.
 ```ruby
 class SessionsController < ApplicationController
   def create
     @user = User.find_or_create_from_auth_hash(auth_hash)
     self.current_user = @user
     redirect_to '/'
   end
 
   protected
 
   def auth_hash
     request.env['omniauth.auth']
   end
 end
 ```
 
 ## Usage - Devise
 If you integrate Devise to your rails project, follows to [Devise - OmniAuth: Overview](https://github.com/plataformatec/devise/wiki/OmniAuth:-Overview), here are some steps.
 
 If you have no `config/initializers/devise.rb`, run the generator.
 ```
 rails g devise:install
 ```
 
 Add configuration to `config/initializers/devise.rb` for omniauth-gitbook.
 ```ruby
 Devise.setup do |config|
   config.omniauth :gitbook, [CLIENT_ID], [CLIENT_SECRET]
 end
 ```
 
 And if your devise model named `User`, add callback route to `route.rb`.
 ```ruby
 devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth_callbacks' }
 ```

 Then you can get user's data in controller.
 ```ruby
 class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
   def gitbook
     @user = User.find_or_create_by_oauth2(request.env[omniauth.auth])
     
     if @user.persisted?
       sign_in_and_redirect_to root_path, event: :authentication
     end
   end
 end
 ```
 
 ## What data exactly you retrieved from `omniauth-gitbook`
 Here is the json structure.
 ```json
 {  
    "provider":"gitbook",
    "uid":"[UID]",
    "info":{  
       "username":"calvinhuang",
       "name":"Calvin-Huang",
       "website":"https://github.com/Calvin-Huang",
       "urls":{  
          "profile":"https://www.gitbook.com/@calvin-huang",
          "stars":"https://www.gitbook.com/@calvin-huang/starred",
          "avatar":"https://avatars0.githubusercontent.com/Calvin-Huang"
       },
       "auth":{  
          "token":"[TOKEN]",
          "password":false,
          "verified":false
       },
       "token":"[TOKEN]"
    },
    "credentials":{  
       "token":"[TOKEN]",
       "expires":false
    },
    "extra":{  
       "raw_info":{  
          "id":"[UID]",
          "type":"User",
          "username":"calvinhuang",
          "name":"Calvin-Huang",
          "location":"",
          "website":"https://github.com/Calvin-Huang",
          "verified":false,
          "locked":false,
          "site_admin":false,
          "urls":{  
             "profile":"https://www.gitbook.com/@calvin-huang",
             "stars":"https://www.gitbook.com/@calvin-huang/starred",
             "avatar":"https://avatars0.githubusercontent.com/calvin-huang"
          },
          "permissions":{  
             "edit":true,
             "admin":true
          },
          "dates":{  
             "created":"2016-10-01T08:51:37.391Z"
          },
          "counts":{  
 
          },
          "github":{  
             "username":"Calvin-Huang",
             "scopes":[  
                ""
             ],
             "required":true
          },
          "plan":{  
             "id":"free"
          },
          "auth":{  
             "token":"[TOKEN]",
             "password":false,
             "verified":false
          },
          "token":"[TOKEN]"
       }
    },
    "books":{  
       "list":[  
          {  
             "id":"calvinhuang/test",
             "status":"published",
             "name":"test",
             "title":"test",
             "description":"",
             "public":true,
             "topics":[  
    
             ],
             "license":"nolicense",
             "language":"en",
             "locked":false,
             "cover":{  
                "large":"[URL]",
                "small":"[URL]"
             },
             "urls":{  
                "git":"https://git.gitbook.com/calvinhuang/test.git",
                "access":"https://www.gitbook.com/book/calvinhuang/test",
                "homepage":"https://calvinhuang.gitbooks.io/test/",
                "read":"https://www.gitbook.com/read/book/calvinhuang/test",
                "edit":"https://www.gitbook.com/book/calvinhuang/test/edit",
                "content":"https://fennyliang.gitbooks.io/test/content/",
                "download":{  
                   "epub":"https://www.gitbook.com/download/epub/book/calvinhuang/test",
                   "mobi":"https://www.gitbook.com/download/mobi/book/calvinhuang/test",
                   "pdf":"https://www.gitbook.com/download/pdf/book/calvinhuang/test"
                }
             },
             "counts":{  
                "stars":0,
                "subscriptions":1,
                "updates":1,
                "discussions":0,
                "collaborators":0
             },
             "dates":{  
                "build":"2016-10-03T05:29:17.696Z",
                "created":"2016-10-03T05:28:37.865Z"
             },
             "permissions":{  
                "edit":true,
                "admin":true,
                "important":true
             },
             "publish":{  
                "defaultBranch":"master",
                "builder":"default"
             },
             "author":{  
                "id":"[UID]",
                "type":"User",
                "username":"calvinhuang",
                "name":"Calvin-Huang",
                "location":"",
                "website":"https://github.com/Calvin-Huang",
                "verified":false,
                "locked":false,
                "site_admin":false,
                "urls":{  
                   "profile":"https://www.gitbook.com/@calvinhuang",
                   "stars":"https://www.gitbook.com/@calvinhuang/starred",
                   "avatar":"https://avatars0.githubusercontent.com/Calvin-Huang"
                },
                "permissions":{  
                   "edit":null,
                   "admin":null
                },
                "dates":{  
                   "created":"2016-10-01T08:51:37.391Z"
                },
                "counts":{  
    
                },
                "github":{  
                   "username":"Calvin-Huang"
                }
             }
          }
       ],
       "total":1,
       "limit":50,
       "page":0,
       "pages":1
    }
 }
 ```
 
 ## TO-DO
 - [ ] Paginate books.
 - [ ] Provide Gem to interact with GitBook API.
 
 ## Contribution
 I'm appreciate at any improvement, please feel free to open PR / Issue to this repo or you can contact [me](https://github.com/Calvin-Huang).
 
 ## License
 Copyright (c) [Calvin Huang](https://github.com/Calvin-Huang). This software is licensed under the [MIT License](https://github.com/Calvin-Huang/CHRealHideUIView/blob/master/LICENSE).