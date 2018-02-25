class System::CentralController < ApplicationController
	before_action :authenticate_user!
	respond_to :json, :html, :js
	layout "inside"
	before_action :setNotifications

	def index

	end
	def notifications

		respond_to do |format|
		  format.html { render :html => @send}
		  format.json { render :json => @send }
		  format.js   { render :layout => false }
		end
	end

	def setNotifications
		@send = []
		System::BugMessage.joins('inner join system_bugs on system_bugs.id = system_bug_messages.system_bug_id').where("user_id = #{current_user.id} and message_to like \"user\"").order(updated_at: :desc).each do |notification|
			@send.push notification
		end
	end

	def setLocate
		I18n.locale = params['locate']

		respond_to do |format|
		  format.html { render :html => I18n.locale}
		  format.json { render :json => I18n.locale }
		  format.js   { render :layout => false }
		end
	end
end
