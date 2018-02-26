class MediafilesController < ApplicationController
  before_action :authenticate_user!
  layout "inside"
  respond_to :json, :html, :js
  skip_before_filter :verify_authenticity_token, :only => :destroy
  before_action :set_mediafile, only: [:show, :edit, :update, :destroy]

  # GET /mediafiles
  def index
    @mediafiles = Mediafile.search(params[:search]).page(params[:page])
    @total = Mediafile.all.length
  end

  # GET /mediafiles/1
  def show
  end

  # GET /mediafiles/new
  def new
    @mediafile = Mediafile.new
  end

  # GET /mediafiles/1/edit
  def edit
  end

  # POST /mediafiles
  def create
    @mediafile = Mediafile.new(mediafile_params)

    if @mediafile.save
      redirect_to mediafiles_path, notice: 'Mediafile was successfully created.'
    else
      render :new
    end
  end

  # PATCH/PUT /mediafiles/1
  def update
    if @mediafile.update(mediafile_params)
      redirect_to mediafiles_path, notice: 'Mediafile was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /mediafiles/1
  def destroy

    @mediafiles = Mediafile.find(params[:id])
    @mediafile.destroy
    redirect_to(:back)
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_mediafile
      @mediafile = Mediafile.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def mediafile_params
      params.require(:mediafile).permit(:references, :name)
    end
end
