class System::BugStatusesController < ApplicationController
  before_action :authenticate_user!
  before_action :verify_access
	layout "inside"
  respond_to :json, :html, :js
  skip_before_filter :verify_authenticity_token, :only => :destroy
  before_action :set_system_bug_status, only: [:show, :edit, :update, :destroy]

  def index
    @system_bug_statuses = System::BugStatus.search(params[:search]).page(params[:page])
    respond_with(@system_bug_statuses)
  end

  def show
    respond_with(@system_bug_status)
  end

  def new
    @system_bug_status = System::BugStatus.new
    respond_with(@system_bug_status)
  end

  def edit
  end

  def create
    @system_bug_status = System::BugStatus.new(bug_status_params)
    @system_bug_status.save
    respond_with(@system_bug_status)
  end

  def update
    @system_bug_status.update(bug_status_params)
    respond_with(@system_bug_status)
  end

  def destroy
    @system_bug_status.destroy
    respond_with(@system_bug_status)
  end

  private
    def set_system_bug_status
      @system_bug_status = System::BugStatus.find(params[:id])
    end

    def bug_status_params
      params.require(:system_bug_status).permit(:description)
    end
end
