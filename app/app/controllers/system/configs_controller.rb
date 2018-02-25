class System::ConfigsController < ApplicationController
  before_action :authenticate_user!
  before_action :verify_access
  before_action :set_system_config, only: [:show, :edit, :update, :destroy]
  layout "inside"
  respond_to :json, :html, :js
  skip_before_filter :verify_authenticity_token, :only => :destroy

  def index
    redirect_to "/system/configs/1/edit"
  end

  def show
    redirect_to "/system/configs/1/edit"
  end

  def new
    @system_config = System::Config.new
    respond_with(@system_config)
  end

  def edit
  end

  def create
    @system_config = System::Config.new(system_config_params)
    @system_config.save
    respond_with(@system_config)
  end

  def update
    if @system_config.update(system_config_params)
      redirect_to action: "index"
    else
      respond_with(@category_program)
    end
  end

  def destroy
    @system_config.destroy
    respond_with(@system_config)
  end

  private
    def set_system_config
      @system_config = System::Config.find(params[:id])
    end

    def system_config_params
      params.require(:system_config).permit(:name_sort, :name_company, :address_company, :country_company, :email_company, :phone_company, :terms_of_user_last_change, :privacity_last_change, :at_home_version_repository, :google_maps_id, :google_analytics_id, :system_color,:system_color_disabled,:system_danger_color,:country_code,:email_password,:email_user)
    end
end
