class System::HelpController < ApplicationController
	before_action :authenticate_user!
	layout "help"
	def index
	end
end
