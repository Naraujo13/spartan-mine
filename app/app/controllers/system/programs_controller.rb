class System::ProgramsController < ApplicationController
  before_action :authenticate_user!
  before_action :verify_access
  before_action :set_system_program, only: [:show, :edit, :update, :destroy]
  layout "inside"
  respond_to :json, :html, :js
  skip_before_filter :verify_authenticity_token, :only => :destroy

  def index
    @system_programs = System::Program.search(params[:search]).page(params[:page])
    respond_with(@system_programs)
  end

  def show
    respond_with(@system_program)
  end

  def new
    @system_program = System::Program.new
    respond_with(@system_program)
  end

  def edit
  end

  def create
    @system_program = System::Program.new(program_params)
    if @system_program.save
      redirect_to action: "index"
    else
      respond_with(@system_program)
    end
  end

  def update
    @system_program.update(program_params)
    respond_with(@system_program)
  end

  def destroy
    @system_program.destroy
    respond_with(@system_program)
  end

  def getSearch
    query = params['query'];
    @search = System::Program.where("name LIKE ?", "%#{query}%")
    respond_to do |format|
      format.json { render :json => @search }
    end
  end

  private
    def set_system_program
      @system_program = System::Program.find(params[:id])
      if params[:category_program_id]
        @predio.category_program_id = System::CategoryProgram.find(params[:category_program_id])
      end
    end

    def program_params
      params.require(:system_program).permit(:locate_label, :description, :path, :category_program_id, :icon, :visible)
    end

end
