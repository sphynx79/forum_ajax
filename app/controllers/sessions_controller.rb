class SessionsController < Devise::SessionsController
  prepend_before_filter :allow_params_authentication!, :only => :create

   def new
      super
   end



   # POST /resource/sign_in
   def create
      @resource = warden.authenticate!(:scope => resource_name, :recall => "#{controller_path}#failure")
      set_flash_message(:notice, :signed_in) if is_flashing_format?
      #sign_in(resource_name, @resource)
      sign_in_without_redirect(resource_name, @resource)
      respond_to do |format|
         format.html { 
            yield resource if block_given?
            respond_with @resource, :location => after_sign_in_path_for(@resource) 
         }
         # format.js{ render :template => "remote_content/devise_success_sign_in.js.erb"}
         
         format.js {return render :js => "window.location.href = '#{@after_sign_in_path }'"}
         
      end
   end

   def failure
      render :template => "remote_content/devise_errors.js.erb"
      flash.discard
   end

   def sign_in_without_redirect(resource_or_scope, resource=nil)
      scope = Devise::Mapping.find_scope!(resource_or_scope)
      resource ||= resource_or_scope
       sign_in(scope, resource) unless warden.user(scope) == resource
   end

   
end
