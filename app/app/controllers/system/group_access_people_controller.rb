class System::GroupAccessPeopleController < ApplicationController
  before_action :set_system_group_access_person, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!
  before_action :verify_access
  respond_to :json, :html, :js

  def index
    redirect_to "/dashboard"
  end

  #def show
  #  respond_with(@system_group_access_person)
  #end

  #def new
  #  @system_group_access_person = System::GroupAccessPerson.new
  #  respond_with(@system_group_access_person)
  #end

  #def edit
  #end

  def create
    @system_group_access_person = System::GroupAccessPerson.new(system_group_access_person_params)
    @system_group_access_person.save
    respond_with(@system_group_access_person)
  end

  #def update
  #  @system_group_access_person.update(system_group_access_person_params)
  #  respond_with(@system_group_access_person)
  #end

  def destroy
    @system_group_access_person.destroy
    respond_with(@system_group_access_person)
  end

  def list
    query = params['users_id']
    @lista = System::GroupAccessPerson.select('system_group_access_people.id, system_group_accesses.name').joins('left join users on users.id = users_id left join system_group_accesses on system_group_accesses.id = system_group_access_id').where("users_id = ?","#{query}")
    respond_to do |format|
      format.json { render :json => @lista }
    end
  end

  def insert
    logger.info system_group_access_person_params
    @system_group_access_program =  System::GroupAccessPerson.new(system_group_access_person_params)
    respond_to do |format|
      if @system_group_access_program.save
        format.json { render json: @system_group_access_program }
      else
        format.json { render json: @system_group_access_program.errors, status: :unprocessable_entity }
      end
    end
  end

  def listProgramsByUser
    query = params['user_id']
    @lista = System::GroupAccessPerson.select("distinct system_group_access_programs.system_programs_id as id").joins('left join system_group_access_programs on  system_group_access_people.system_group_access_id = system_group_access_programs.system_group_accesses_id').where("system_group_access_people.users_id = ?","#{query}")
    respond_to do |format|
      format.json { render :json => @lista }
    end
  end

  private
    def set_system_group_access_person
      @system_group_access_person = System::GroupAccessPerson.find(params[:id])
    end

    def system_group_access_person_params
      params.require(:system_group_access_person).permit(:users_id, :system_group_access_id)
    end
end
