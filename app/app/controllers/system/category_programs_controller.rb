class System::CategoryProgramsController < ApplicationController
  before_action :authenticate_user!
  before_action :verify_access
  before_action :set_system_category_program, only: [:show, :edit, :update, :destroy]
  layout "inside"
  respond_to :json, :html, :js
  skip_before_filter :verify_authenticity_token, :only => :destroy

  def index
    @category_programs = System::CategoryProgram.search(params[:search]).page(params[:page])
    respond_with(@category_programs)
  end

  def show
    respond_with(@category_program)
  end

  def new
    @category_program = System::CategoryProgram.new
    respond_with(@category_program)
  end

  def edit
  end

  def create
    @category_program = System::CategoryProgram.new(category_program_params)
    if @category_program.save
      redirect_to action: "index"
    else
      respond_with(@category_program)
    end
  end

  def update
    @category_program.update(category_program_params)
    respond_with(@category_program)
  end

  def destroy
    @category_program.destroy
    respond_with(@category_program)
  end

  private
    def set_system_category_program
      @category_program = System::CategoryProgram.find(params[:id])
    end

    def category_program_params
      params.require(:system_category_program).permit(:locate_label, :icon)
    end

end
