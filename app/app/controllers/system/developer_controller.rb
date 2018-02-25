class System::DeveloperController < ApplicationController
  before_action :authenticate_user!
  before_action :verify_access
  layout "inside"
  def index
  end
end
