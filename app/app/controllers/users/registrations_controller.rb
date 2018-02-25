class Users::RegistrationsController < Devise::RegistrationsController
# before_filter :configure_sign_up_params, only: [:create]
  before_filter :configure_account_update_params, only: [:update]
  layout :resolve_layout

  # GET /resource/sign_up
  def new
     super
  end

  # POST /resource
  def create
    super
    user = params[:user]
    @user = User.where(email: user[:email]).first
    if @user == nil
        @user = User.new
        @user.first_name = user[:first_name]
        @user.last_name = user[:last_name]
        @user.save!
        #System::GroupAccessPerson.create(:users_id=>@user.id, :system_group_access_id=>2)
    else
        @user.first_name = user[:first_name]
        @user.last_name = user[:last_name]
        @user.save!
        #System::GroupAccessPerson.create(:users_id=>@user.id, :system_group_access_id=>2)
    end
  end

  # GET /resource/edit
  def edit
     super
  end

  # PUT /resource
  def update
     super
	 #Atualizando a imagem
	  user = params[:user]
	  @user = User.find(current_user.id)
	  logger.debug @user
	  @user.avatar = user[:avatar]
	  @user.save!
  end

  # DELETE /resource
  # def destroy
  #   super
  # end

  # GET /resource/cancel
  # Forces the session data which is usually expired after sign
  # in to be expired now. This is useful if the user wants to
  # cancel oauth signing in/up in the middle of the process,
  # removing all OAuth session data.
  # def cancel
  #   super
  # end

  # protected

  # You can put the params you want to permit in the empty array.
   def configure_sign_up_params
      devise_parameter_sanitizer.for(:sign_up) { |u| u.permit(:first_name, :last_name, :email,:password,:password_confirmation,:access_token) }
   end

  #You can put the params you want to permit in the empty array.
  def configure_account_update_params
     devise_parameter_sanitizer.for(:account_update) { |u| u.permit(:first_name, :last_name, :born, :email,:current_password,:password,:password_confirmation,:avatar,:filename,:phone_number,:gender,:address,:postal_code,:access_token) }
  end

  def resolve_layout
    case action_name
    when "edit", "update"
      "inside"
    when "new"
      "outside"
    else
      "outside"
    end
  end

  protected
  # The path used after sign up.
  def after_sign_up_path_for(resource)
    super(resource)
    "/users/sign_in"
  end

  # The path used after sign up for inactive accounts.
  def after_inactive_sign_up_path_for(resource)
    "/users/sign_in"
  end

end
