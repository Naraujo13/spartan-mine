class Example::LabController < ApplicationController
  before_action :authenticate_user!
  layout "inside"
  respond_to :json, :html, :js

  def index
    @tags = Example::Tag.search(params[:search]).page(params[:page])
    respond_with(@tags)
  end

end
