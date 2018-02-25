class Public::SiteController < ApplicationController

	respond_to :html
	def index
		if user_signed_in?
			if params[:homepage] == nil
				redirect_to "/dashboard"
			end
		end
	end

	def forbidden
		render :layout => "forbidden"
	end
    
    def without_permissions
        render :layout => "forbidden"
    end

end
