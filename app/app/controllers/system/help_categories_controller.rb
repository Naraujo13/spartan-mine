class System::HelpCategoriesController < ApplicationController
  before_action :set_system_help_category, only: [:show, :edit, :update, :destroy]

  respond_to :html

  def index
    @system_help_categories = System::HelpCategory.all
    respond_with(@system_help_categories)
  end

  def show
    respond_with(@system_help_category)
  end

  def new
    @system_help_category = System::HelpCategory.new
    respond_with(@system_help_category)
  end

  def edit
  end

  def create
    @system_help_category = System::HelpCategory.new(help_category_params)
    @system_help_category.save
    respond_with(@system_help_category)
  end

  def update
    @system_help_category.update(help_category_params)
    respond_with(@system_help_category)
  end

  def destroy
    @system_help_category.destroy
    respond_with(@system_help_category)
  end

  private
    def set_system_help_category
      @system_help_category = System::HelpCategory.find(params[:id])
    end

    def system_help_category_params
      params.require(:system_help_category).permit(:description)
    end
end
