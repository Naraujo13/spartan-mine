class System::BugMessagesController < ApplicationController
  before_action :verify_access
  before_action :authenticate_user!
  layout "inside"
  respond_to :json, :html, :js
  skip_before_filter :verify_authenticity_token, :only =>[ :destroy,:create,:notifications]
  before_action :set_system_bug_message, only: [:show, :edit, :update, :destroy]

  def index
    if current_user.admin
      @system_bug_messages = System::BugMessage.search(params[:search]).page(params[:page]).order(:system_bug_id)
    else
      @system_bug_messages = System::BugMessage.search(params[:search]).page(params[:page]).order(:system_bug_id).joins('inner join system_bugs on system_bugs.id = system_bug_messages.system_bug_id').where('user_id ='+current_user.id.to_s)
    end
    respond_with(@system_bug_messages)
  end

  def new
    @system_bug_message = System::BugMessage.new
  end

  def show
    mensagens = System::BugMessage.joins(:bug).where("user_id = #{current_user.id} and message_to like \"user\"").order(updated_at: :desc)
    respond_to do |format|
      format.html { redirect_to action: 'index' }
      format.json { render :json => mensagens }
      format.js   { render :layout => false }
    end
  end

  def notifications
    begin
      mensagens = System::BugMessage.joins(:bug).where("user_id = #{current_user.id} and displayed = false")
      render json:{
        "actionResponse"=>"notifications",
        "status"=>"200",
        "response"=>mensagens
      }
    rescue Exception => e

      render json: {
        "actionResponse"=>"notifications",
        "status"=>"500",
        "response"=>e.message
      }
    end
  end

  def edit
  end

  def create
    @system_bug_message = System::BugMessage.new(bug_message_params)
    @system_bug_message.save

	if current_user.admin?
		@user = User.find(System::Bug.find(bug_message_params[:system_bug_id]).user_id)
		AthomeMailer.bug_message(@user.first_name,@user.email).deliver
	end

	respond_to do |format|
      format.json { render :json => @system_bug_message }
      format.js   { render :layout => false }
    end
  end

  def update
    @system_bug_message.update(bug_message_params)
  end

  def destroy
    @system_bug_message.destroy
    respond_with(@system_bug_message)
  end

  private

    def set_system_bug_message
      @system_bug_message = System::BugMessage.find(params[:id])
    end

    def bug_message_params
      if current_user.admin?
        params[:bug_message][:message_from] = "admin"
        params[:bug_message][:message_to]="user"
        params[:bug_message][:admin_id]=current_user.id
      else
        params[:bug_message][:message_from] = "user"
        params[:bug_message][:message_to]="admin"
      end
      params.require(:bug_message).permit(:message, :displayed, :message_from, :message_to, :system_bug_id, :admin_id)
    end
end
