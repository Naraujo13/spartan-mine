class System::AccessTosController < ApplicationController
	layout "inside"
  before_action :set_system_access_to, only: [:show, :edit, :update, :destroy]
	before_action :authenticate_user!
  before_action :verify_access
  respond_to :html

  def index
      @system_access_tos = System::AccessTo.all.order(:user_id).page(params[:page])
      @system_access_to_nested_resources = System::AccessToNestedResource.order(:user_id).page(params[:page])
      respond_with(@system_access_tos)
  end

  def show
    respond_with(@system_access_to)
  end

  def new
    @system_access_to = System::AccessTo.new
    respond_with(@system_access_to)
  end

  def edit
  end

  def create
    @system_access_to = System::AccessTo.new(access_to_params)
		if @system_access_to.save
      redirect_to action: "index"
    else
      respond_with(@system_access_to)
    end
  end

  def update
    @system_access_to.update(access_to_params)
    respond_with(@system_access_to)
  end

  def destroy
    @system_access_to.destroy
    respond_with(@system_access_to)
  end

  private
    def set_system_access_to
      @system_access_to = System::AccessTo.find(params[:id])
    end

    def system_access_to_params
      params.require(:system_access_to).permit(:user_id, :program_id)
    end
end
