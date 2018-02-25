class Public::PolicyController < ApplicationController


  def index
    redirect_to "/"
  end

  def terms
    @config = System::Config.first
  end

  def privacy
    @config = System::Config.first
  end
end
