class Example::PostTagsController < ApplicationController
  before_action :set_example_post_tag, only: [:show, :edit, :update, :destroy]

  respond_to :json, :html, :js

  def index
    @example_post_tags = Example::PostTag.search(params[:search]).page(params[:page])
    @total = Example::Post.all.length
    respond_with(@example_post_tags)
  end

  def show
    respond_with(@example_post_tag)
  end

  def new
    @example_post_tag = Example::PostTag.new
    respond_with(@example_post_tag)
  end

  def edit
  end

  def create
    @example_post_tag = Example::PostTag.new(post_tag_params)
    if @example_post_tag.save
      redirect_to action: "index"
    else
      respond_with(@example_post_tag)
    end
  end

  def update
    @example_post_tag.update(post_tag_params)
    respond_with(@example_post_tag)
  end

  def destroy
    respond_to do |format|
        if @example_post_tag.destroy
            format.json { render json: 'success' }
        else
            format.json { render json: @example_post_tag.erros, status: :unprocessable_entity }
        end
    end
  end

  def list
    query = params['example_posts_id']
    @lista = Example::PostTag.select('example_post_tags.id,example_tags.title').joins('left join example_tags on example_tags.id = example_tags_id').where("example_posts_id = ?","#{query}")
    respond_to do |format|
      format.json { render :json => @lista }
    end
  end

  def insert
    logger.info example_post_tag_params
    @example_post_tag =  Example::PostTag.new( example_post_tag_params )
    
    respond_to do |format|
      if @example_post_tag.save
            @example_post_tag = Example::PostTag.select('example_post_tags.id,example_tags.title').joins('join example_tags on example_post_tags.example_posts_id = example_tags.id').where("example_post_tags.id = #{@example_post_tag.id}")
            @example_post_tag = @example_post_tag.first
            format.json { render json: @example_post_tag }
      else
        format.json { render json: @example_post_tag.errors, status: :unprocessable_entity }
      end
    end
  end

  private
    def set_example_post_tag
      @example_post_tag = Example::PostTag.find(params[:id])
    end

    def example_post_tag_params
      params.require(:example_post_tag).permit(:example_posts_id, :example_tags_id)
    end
end
