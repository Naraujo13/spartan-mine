class System::BugsController < ApplicationController
  before_action :authenticate_user!
  before_action :verify_access
  layout "inside"
  respond_to :json, :html, :js
  skip_before_filter :verify_authenticity_token, :only => :destroy
  before_action :set_system_bug, only: [:show, :edit, :update, :destroy]

  respond_to :html

  def index
    if current_user.admin?
  		@system_bugs = System::Bug.where("bug_status_id != 2").search(params[:search]).page(params[:page])
  		render 'indexAdmin.html.erb'
    else
  		@system_bugs = System::Bug.where(:user_id => current_user.id).search(params[:search]).page(params[:page]).order(:bug_status_id)
  		render 'indexUser.html.erb'
    end

  end

  def show
    respond_with(@system_bug)
  end

  def new
    @system_bug = System::Bug.new
    respond_with(@system_bug)
  end

  def edit
    if current_user.admin?
      render 'editAdmin.html.erb'
    else
      if System::Bug.where("user_id = #{current_user.id} and id ="+@system_bug.id.to_s).blank?
        redirect_to "/forbidden?path=#{controller_path}/"+@system_bug.id.to_s+"/edit"
      else
        render 'editUser.html.erb'
      end
    end
  end

  def create
    params[:user_id]=current_user.id
    @system_bug = System::Bug.new(bug_params)
    @system_bug.save
    @user = User.find(current_user.id)
    AthomeMailer.new_bug(@user.first_name+" "+@user.last_name,User.find(1).email).deliver
    respond_with(@system_bug)
  end

  def update
    @system_bug.update(bug_params)
    respond_with(@system_bug)
  end

  def destroy
    @system_bug.destroy
    respond_with(@system_bug)
  end

  private
    def set_system_bug
      @system_bug = System::Bug.find(params[:id])
    end

    def bug_params
      params.require(:system_bug).permit(:problem, :bug_status_id,:user_id)
    end
end
