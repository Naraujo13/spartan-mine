class Public::HelpController < ApplicationController
	layout "help"
	def index
		if user_signed_in?
			redirect_to "/system/help"
		end
	end
end
