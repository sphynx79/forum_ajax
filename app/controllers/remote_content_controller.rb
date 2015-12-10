class RemoteContentController < ApplicationController
   def remote_sign_in
       respond_to do |format|
         format.html {redirect_to new_user_session_path}
         format.js {render 'remote_sign_in'}
       end
   end

   def remote_sign_up
       respond_to do |format|
         format.html {redirect_to new_user_registration_path}
         format.js {render 'remote_sign_up'}
       end
   end
end
