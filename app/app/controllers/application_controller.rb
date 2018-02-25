require 'jasper_report'

class ApplicationController < ActionController::Base
  	# Prevent CSRF attacks by raising an exception.
  	# For APIs, you may want to use :null_session instead.
	protect_from_forgery with: :exception, prepend: true
	config.encoding = "utf-8"
	layout "outside"


	def verify_access
		if System::GroupAccessPerson.joins('left join system_group_access_programs on system_group_access_people.system_group_access_id = system_group_access_programs.system_group_accesses_id left join system_programs on system_programs.id  = system_group_access_programs.system_programs_id').where("system_group_access_people.users_id=#{current_user.id} AND system_programs.path like '%#{controller_path}%'").blank?
			if System::AccessTo.joins(:program).where("user_id=#{current_user.id} AND path like '%#{controller_path}%'").blank?
				nesteds = System::AccessToNestedResource.where("user_id=#{current_user.id}")
				canAccess = false
				nesteds.each do | nested |
					if controller_path.match(nested.path)
						canAccess = true
					end
				end
				if not canAccess
		    	redirect_to "/forbidden?path=#{controller_path}"
				end
		  end
		end
	end

	def respond_to_report(p_name, p_report_url, p_params, p_report_type)
	  @report = JasperReport.new(p_name, p_report_url, p_params, p_report_type)
	  return @report.get_report
	end

end
