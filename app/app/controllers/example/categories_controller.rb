class Example::CategoriesController < ApplicationController
  before_action :authenticate_user!
  before_action :verify_access
  layout "inside"
  respond_to :json, :html, :js
  skip_before_filter :verify_authenticity_token, :only => :destroy
  before_action :set_example_category, only: [:show, :edit, :update, :destroy]

  respond_to :html

  def index
    @example_categories = Example::Category.search(params[:search]).page(params[:page])
    @total = Example::Category.all.length
    respond_with(@example_categories)
  end

  def show
    respond_with(@example_category)
  end

  def new
    @example_category = Example::Category.new
    respond_with(@example_category)
  end

  def edit
  end

  def create
    @example_category = Example::Category.new(example_category_params)
    if @example_category.save
      redirect_to action: "index"
    else
      respond_with(@example_post_tag)
    end
  end

  def update
    @example_category.update(example_category_params)
    respond_with(@example_category)
  end

  def destroy
    @example_category.destroy
    respond_with(@example_category)
  end

  def getSearch
    query = params['query'];
    @search = Example::Category.where("description LIKE ?", "%#{query}%")
    respond_to do |format|
      format.json { render :json => @search }
    end
  end
    
  def report
    report_params = nil
    @result = respond_to_report(params[:p_name], params[:p_report_url],report_params,params[:p_report_type])
    respond_to do |format|
      format.json { render :json => @result }
    end
  end

  private
    def set_example_category
      @example_category = Example::Category.find(params[:id])
    end

    def example_category_params
      params.require(:example_category).permit(:description, :position)
    end
end
