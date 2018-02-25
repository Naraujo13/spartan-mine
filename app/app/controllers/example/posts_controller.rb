class Example::PostsController < ApplicationController
  before_action :authenticate_user!
  before_action :verify_access
  layout "inside"
  respond_to :json, :html, :js
  skip_before_filter :verify_authenticity_token, :only => :destroy
  before_action :set_example_post, only: [:show, :edit, :update, :destroy]

  def index
    @example_posts = Example::Post.search(params[:search]).page(params[:page])
    @total = Example::Post.all.length
    respond_with(@example_posts)
  end

  def show
    respond_with(@example_post)
  end

  def new
    @example_post = Example::Post.new
    respond_with(@example_post)
  end

  def edit
  end

  def create
    @example_post = Example::Post.new(example_post_params)
    if @example_post.save
      redirect_to action: "index"
    else
      respond_with(@example_post)
    end
  end

  def update
    @example_post.update(example_post_params)
    respond_with(@example_post)
  end

  def destroy
    @example_post.destroy
    respond_with(@example_post)
  end
    
  def report
    report_params = nil
    @result = respond_to_report(params[:p_name], params[:p_report_url],report_params,params[:p_report_type])
    respond_to do |format|
      format.json { render :json => @result }
    end
  end

  private
    def set_example_post
      @example_post = Example::Post.find(params[:id])
    end

    def example_post_params
      params.require(:example_post).permit(:title, :description, :content,:url_image, :publish_at, :public, :plus_one, :example_category_id, :position)
    end
end
