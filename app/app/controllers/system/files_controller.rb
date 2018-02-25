class System::FilesController < ApplicationController
  require 'fileutils'
  before_action :authenticate_user!
  before_action :verify_access
  before_action :set_system_file, only: [:show, :edit, :update, :destroy]
  layout "inside"
  respond_to :json, :html, :js

  def index

    if( User.find(current_user.id).admin)
      @system_files = System::File.search(params[:search]).page(params[:page])
    else
      @system_files = System::File.where("user_id ="+current_user.id.to_s+" or public like 't'").search(params[:search]).page(params[:page])
    end
    respond_with(@system_files)
  end

  def show
    respond_with(@system_file)
  end

  def new
    @system_file = System::File.new
    respond_with(@system_file)
  end

  def edit
  end

  def create
    logger.info "On Create!"
    logger.info system_file_params
    logger.info "Name"
    logger.info system_file_params[:name]
    file = {}
    fi = system_file_params[:name]
    fi.each do |p_file|
        begin
            uploader = UploadUploader.new
            uploader.userId current_user.id
            file['file'] = uploader.store!(p_file) #2
            file['fileName'] = uploader.get_filename #1
            file['id'] = system_file_params[:user_id] #0
            type = uploader.get_original_name.split('.')
            type = type[type.length-1]
            @system_file = System::File.new(:content_type => type, :original_name => uploader.get_original_name,:name => uploader.get_filename ,:public=>system_file_params['public'],:user_id=>current_user.id,:path=>uploader.current_path)
        rescue Exception => e
            @system_file = {}
            @system_file['file'] = "error" #2
            logger.error e
            @system_file['id'] = system_file_params[:id] #0
        end
    end
    if @system_file.save
      redirect_to action: "index"
    else
      respond_with(@system_file)
    end
  end

  def update
    @system_file.update(system_file_params)
    respond_with(@system_file)
  end

  def destroy
    FileUtils.rm("./public/data/"+@system_file.name)
    @system_file.destroy
    respond_with(@system_file)
  end

  private
    def set_system_file
      @system_file = System::File.find(params[:id])
    end

    def system_file_params
      params.require(:system_file).permit({name: []}, :original_name, :path, :user_id, :public,:type)
    end
end
