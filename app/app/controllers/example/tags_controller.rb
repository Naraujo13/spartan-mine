class Example::TagsController < ApplicationController
  before_action :authenticate_user!
  before_action :verify_access
  layout "inside"
  respond_to :json, :html, :js
  skip_before_filter :verify_authenticity_token, :only => :destroy
  before_action :set_example_tag, only: [:show, :edit, :update, :destroy]

  def index
    @example_tags = Example::Tag.search(params[:search]).page(params[:page])
    @total = Example::Tag.all.length
    respond_with(@example_tags)
  end

  def show
    respond_with(@example_tag)
  end

  def new
    @example_tag = Example::Tag.new
    respond_with(@example_tag)
  end

  def edit
  end

  def create
    @example_tag = Example::Tag.new(example_tag_params)
    if @example_tag.save
      redirect_to action: "index"
    else
      respond_with(@example_tag)
    end
  end

  def update
    if @example_tag.update(example_tag_params)
        redirect_to action: "index"
    else
        respond_with(@example_tag)
    end
  end

  def destroy
    @example_tag.destroy
    respond_with(@example_tag)
  end

  def getSearch
    query = params['query'];
    @search = Example::Tag.where("title LIKE ?", "%#{query}%")
    respond_to do |format|
      format.json { render :json => @search }
    end
  end

  def report
    logger.info params 
    report_params = nil
    @result = respond_to_report(params[:p_name], params[:p_report_url],report_params,params[:p_report_type])
    respond_to do |format|
        format.json { render :json => @result }
    end
  end

  private
    def set_example_tag
      @example_tag = Example::Tag.find(params[:id])
    end

    def example_tag_params
      params.require(:example_tag).permit(:title, :active)
    end
end
