class System::GroupAccessesController < ApplicationController
  before_action :set_system_group_access, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!
  before_action :verify_access
  layout "inside"
  respond_to :json, :html, :js

  def index
    @system_group_accesses = System::GroupAccess.search(params[:search]).page(params[:page])
    respond_with(@system_group_accesses)
  end

  def show
    respond_with(@system_group_access)
  end

  def new
    @system_group_access = System::GroupAccess.new
    respond_with(@system_group_access)
  end

  def edit
  end

  def create
    @system_group_access = System::GroupAccess.new(system_group_access_params)
    @system_group_access.save
    if @system_group_access.save
      redirect_to action: "index"
    else
      respond_with(@system_group_access)
    end
  end

  def update
    @system_group_access.update(system_group_access_params)
    respond_with(@system_group_access)
  end

  def destroy
    @system_group_access.destroy
    respond_with(@system_group_access)
  end

  def getSearch
    query = params['query'];
    @search = System::GroupAccess.where("name LIKE ?", "%#{query}%")
    respond_to do |format|
      format.json { render :json => @search }
    end
  end

  private
    def set_system_group_access
      @system_group_access = System::GroupAccess.find(params[:id])
    end

    def system_group_access_params
      params.require(:system_group_access).permit(:name,:description, :active)
    end
end
