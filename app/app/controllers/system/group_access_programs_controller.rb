class System::GroupAccessProgramsController < ApplicationController
  before_action :set_system_group_access_program, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!
  before_action :verify_access
  respond_to :json, :html, :js

  def index
    redirect_to "/dashboard"
  end

  #def show
  #  respond_with(@system_group_access_program)
  #end

  #def new
  #  @system_group_access_program = System::GroupAccessProgram.new
  #  respond_with(@system_group_access_program)
  #end

  #def edit
  #end

  def create
    @system_group_access_program = System::GroupAccessProgram.new(system_group_access_program_params)
    @system_group_access_program.save
    respond_with(@system_group_access_program)
  end

  #def update
  #  @system_group_access_program.update(system_group_access_program_params)
  #  respond_with(@system_group_access_program)
  #end

  def destroy
    @system_group_access_program.destroy
    respond_with(@system_group_access_program)
  end

  def list
    query = params['system_group_accesses_id']
    @lista = System::GroupAccessProgram.select('system_group_access_programs.id,system_programs.locate_label').joins('left join system_programs on system_programs.id = system_programs_id').where("system_group_accesses_id = ?","#{query}")
    @lista_to_send = []
    @lista.each do |register|
        label = t(register.locate_label)
       @lista_to_send.push({id: register.id,name: label}) 
    end
    respond_to do |format|
      format.json { render :json => @lista_to_send }
    end
  end


  def insert
    logger.info system_group_access_program_params
    @system_group_access_program =  System::GroupAccessProgram.new(system_group_access_program_params)
    respond_to do |format|
      if @system_group_access_program.save
        format.json { render json: @system_group_access_program }
      else
        format.json { render json: @system_group_access_program.errors, status: :unprocessable_entity }
      end
    end
  end

  private
    def set_system_group_access_program
      @system_group_access_program = System::GroupAccessProgram.find(params[:id])
    end

    def system_group_access_program_params
      params.require(:system_group_access_program).permit(:system_group_accesses_id, :system_programs_id)
    end
end
