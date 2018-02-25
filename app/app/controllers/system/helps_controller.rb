class System::HelpsController < ApplicationController
  before_action :set_system_help, only: [:show, :edit, :update, :destroy]

  respond_to :html

  def index
    @system_helps = System::Help.all
    respond_with(@system_helps)
  end

  def show
    respond_with(@system_help)
  end

  def new
    @system_help = System::Help.new
    respond_with(@system_help)
  end

  def edit
  end

  def create
    @system_help = System::Help.new(help_params)
    @system_help.save
    respond_with(@system_help)
  end

  def update
    @system_help.update(help_params)
    respond_with(@system_help)
  end

  def destroy
    @system_help.destroy
    respond_with(@system_help)
  end

  private
    def set_system_help
      @system_help = System::Help.find(params[:id])
    end

    def system_help_params
      params.require(:system_help).permit(:name, :sort_description, :like, :type, :post, :viewed, :link, :featured)
    end
end
