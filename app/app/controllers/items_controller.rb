class ItemsController < ApplicationController
  before_action :authenticate_user!
  layout "inside"
  respond_to :json, :html, :js
  skip_before_filter :verify_authenticity_token, :only => :destroy
  before_action :set_item, only: [:show, :edit, :update, :destroy]

  # GET /items
  def index
    @items = Item.search(params[:search]).page(params[:page])
    @total = Item.all.length
  end

  # GET /items/1
  def show
  end

  # GET /items/new
  def new
    
    @item = Item.new
    
    @mediafile = @item.mediafiles.build
    @attached_mediafiles = []

  end

  # GET /items/1/edit
  def edit

    @mediafile = @item.mediafiles.build
    @attached_mediafiles = Mediafile.where(item_id: @item.id).all

  end

  # POST /items
  def create
    @item = Item.new(item_params)

    @item.collection_id = params[:item]["collection_id"]

    respond_to do |format|
      if @item.save
        params[:mediafiles]['file'].each do |f|
           @mediafile = @item.mediafiles.create!(:file => f)
        end
        format.html { redirect_to items_path, notice: 'Item was successfully created.' }
      else
        format.html { render action: 'new' }
      end
    end

  end

  # PATCH/PUT /items/1
  def update

    respond_to do |format|
      if @item.update(item_params)
        
        @item.collection_id = params[:item]["collection_id"]
        @item.save

        params[:mediafiles]['file'].each do |f|
           @mediafile = @item.mediafiles.create!(:file => f)
        end
        
        format.html { redirect_to items_path, notice: 'Item was successfully updated.' }
      else
        format.html { render action: 'edit' }
      end
    end

  end

  # DELETE /items/1
  def destroy
    if params[:controller] == "mediafiles"
      mediafile = Mediafile.find[params[:id]]
      mediafile.destroy
    else
      @item.destroy
      redirect_to items_url, notice: 'Item was successfully destroyed.'
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_item
      @item = Item.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def item_params
      params.require(:item).permit(:item_id, :name, :references, :year, :status, :lenght, :height, :width, :thickness, :aquisition_date, :outer_circumference, :inner_circumference, :weight, :conservation_state, :biography, :description, {mediafiles: []})
    end
end
