require 'open-uri'
class System::UpdaterController < ApplicationController
  layout "inside"
  before_action :authenticate_user!
  before_action :verify_access
  
  def index

    @git_updated = false
    @response_git_ok = true

    @config = System::Config.first

    begin
      @response_git = open("https://api.github.com/repos/"+@config.at_home_version_repository+"/releases/latest").read
      @response_git = JSON.parse(@response_git)
      if @response_git['tag_name'] == t('app_version')
        @git_updated = true
      end
    rescue
      @response_git_ok = false
    end

    @git_local = false
    if %x{ which git } != ""
      @git_local = true
    end

    @git_remote = %x[git remote -v 2>&1]
    @git_remote = @git_remote.include? @config.at_home_version_repository


  end
end
