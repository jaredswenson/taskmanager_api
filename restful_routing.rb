             Prefix Verb URI Pattern                    Controller#Action
      auth_register POST /auth/register(.:format)       users#register
auth_getuserbyemail POST /auth/getuserbyemail(.:format) users#getuserbyemail
 auth_resetpassword POST /auth/resetpassword(.:format)  users#resetpassword
         auth_login POST /auth/login(.:format)          users#login
                set GET  /set(.:format)                 users#set
        task_create POST /task/create(.:format)         tasks#create
           task_get POST /task/get(.:format)            tasks#get
      task_complete POST /task/complete(.:format)       tasks#complete
         task_hours POST /task/hours(.:format)          tasks#hours
