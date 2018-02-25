class AccountsController < ApplicationController
	before_action :authenticate_user!
	before_action :verify_access
	layout "inside"
	respond_to :json, :html, :js
	before_action :set_user, only: [:show, :edit, :update, :destroy]
	skip_before_filter :verify_authenticity_token, :only => :destroy

	def index
		@users = User.search(params[:search]).page(params[:page])
        @total = @users.length
		respond_with(@users)
	end

	def show
		@user = User.find(params[:id])
    	respond_with(@user)
	end

	def new
		@user = User.new
	end

	def edit
	end

	def create
		@user = User.new(user_params)
        if @user.save!(:validate => false)
            if not user_params[:password].empty?
                AthomeMailer.welcome_email( user_params[:first_name], user_params[:email], user_params[:password]).deliver_later
                System::GroupAccessPerson.create(:users_id=>@user.id, :system_group_access_id=>2)
            end
            respond_to do |format|
                format.html { redirect_to action: 'index' }
                format.json { head :no_content}
                format.js   { render :layout => false }
            end
        else
            respond_with(@user)
        end
	end

	def become
        return unless current_user.admin?
        sign_in(:user, User.find(params[:user_id]))
            #cookies[:user_admin_id] = current_user.id
        redirect_to root_url # or user_root_url
    end

	def update
	  System::AccessTo.destroy_all(:user_id=>@user.id)
	  values = user_params[:access_to].split(',');
	  logger.debug "values #{values}"
	  values.each do |value|
	  	logger.debug "value #{value}"
	  	@program = System::AccessTo.new("user_id"=>@user.id,"program_id"=>value)
	  	@program.save
	  end
	  user_params.delete(:access_to)
	  parm_date = params[:user]
	  day 	= parm_date["born(3i)"].to_i
	  month = parm_date["born(2i)"].to_i
	  year	= parm_date["born(1i)"].to_i
	  date 	= Date.new(year,month,day)
	  if user_params[:password].empty?
  	  	@user.update_attributes(:first_name=>user_params[:first_name],:last_name=>user_params[:last_name],:admin=>user_params[:admin],:email=>user_params[:email],:born=>date,:phone_number=>user_params[:phone_number])
  	  else
  	  	@user.update_attributes(:first_name=>user_params[:first_name],:admin=>user_params[:admin],:password_confirmation=>user_params[:password_confirmation],:password=>user_params[:password],:last_name=>user_params[:last_name],:email=>user_params[:email],:born=>date,:phone_number=>user_params[:phone_number])
  	  end
	  AthomeMailer.change_account_email(user_params[:first_name],user_params[:email]).deliver_later
	  respond_to do |format|
	    format.html { redirect_to action: 'index' }
	    format.json { head :no_content}
	    format.js   { render :layout => false }
	  end
	end

	def update_access_to

	end

	def destroy
	  AthomeMailer.destroy_email(@user.first_name,@user.email).deliver_later
		@user = User.find(@user.id)
	  @user.destroy
	  respond_to do |format|
	    format.html { redirect_to action: 'index' }
	    format.json { head :no_content}
	    format.js   { render :layout => false }
	  end
	end

	private
	  def set_user
	    @user = User.find(params[:id])
	  end

	  def user_params
	    params.require(:user).permit(:first_name, :last_name, :email,:password,:access_to,:born, :admin,:phone_number,:access_token)
	  end

end
