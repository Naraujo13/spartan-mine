class System::AccessToNestedResourcesController < ApplicationController
  before_action :set_system_access_to_nested_resource, only: [:show, :edit, :update, :destroy]
  layout "inside"
  before_action :authenticate_user!
  before_action :verify_access
  respond_to :html

  def index
    @system_access_to_nested_resources = System::AccessToNestedResource.search(params[:search]).page(params[:page])
    respond_with(@system_access_to_nested_resources)
  end

  def show
    respond_with(@system_access_to_nested_resource)
  end

  def new
    @system_access_to_nested_resource = System::AccessToNestedResource.new
    respond_with(@system_access_to_nested_resource)
  end

  def edit
  end

  def create
    @system_access_to_nested_resource = System::AccessToNestedResource.new(system_access_to_nested_resource_params)
    if @system_access_to_nested_resource.save
      redirect_to url_for(:controller => :access_tos, :action => :index)
    else
      respond_with(@system_access_to_nested_resource)
    end

  end

  def update
    if @system_access_to_nested_resource.update(system_access_to_nested_resource_params)
      redirect_to url_for(:controller => :access_tos, :action => :index)
    else
      respond_with(@system_access_to_nested_resource)
    end
  end

  def destroy
    @system_access_to_nested_resource.destroy
    respond_with(@system_access_to_nested_resource)
  end

  private
    def set_system_access_to_nested_resource
      @system_access_to_nested_resource = System::AccessToNestedResource.find(params[:id])
    end

    def system_access_to_nested_resource_params
      params.require(:system_access_to_nested_resource).permit(:user_id, :path)
    end
end
