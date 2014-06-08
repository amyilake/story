class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_action :configure_permitted_parameters, if: :devise_controller?

  serialization_scope :view_context
 
  def login_required
    if current_user.blank?
      respond_to do |format|
        format.html{
          authenticate_user!
        }
        format.js{
          render :partial => "common/not_logined"
        }
        format.all{
          head(:unauthorized)
        }
      end
    end
 end


  protected

    def configure_permitted_parameters
      devise_parameter_sanitizer.for(:sign_up) { |u| u.permit(:name, :email, :password, :password_confirmation, :remember_me, :image , :image_cache) }
      devise_parameter_sanitizer.for(:account_update) { |u| u.permit(:name, :email, :password, :password_confirmation, :current_password, :image , :image_cache ) }
    end
end

