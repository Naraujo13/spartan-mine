class AthomeMailer < ActionMailer::Base

    # See more
    #   https://github.com/glaucomunsberg/atHome/wiki/athome_mailer

    default :from => "revistaabacontato@gmail.com"
    default :password => "6yhn@7ujm"

	def welcome_email(name,email,password)
		@name = name
		@email = email
		@password = password
        app_name = System::Config.first.name_sort
		mail(to: @email, subject: app_name+' | '+t("app_mailer_welcome"))
	end

	def change_account_email(name,email)
		@name = name
		@email = email
        app_name = System::Config.first.name_sort
		mail(to: @email, subject: app_name+' | '+t("app_mailer_modified"))
	end

	def destroy_email(name,email)
		@name = name
		@email = email
        app_name = System::Config.first.name_sort
		mail(to: @email, subject: app_name+' | '+t("app_mailer_account_end"))
	end


	def bug_message(name,email)
		@name = name
		@email = email
        app_name = System::Config.first.name_sort
		mail(to: @email, subject: app_name+' | '+t("app_mailer_new_messange"))
	end

	def new_bug(name,email)
		@name = name
		@email = email
        app_name = System::Config.first.name_sort
		mail(to: @email, subject: app_name+' | '+t("app_mailer_new_bug"))
	end

    def voucher(name,email,voucher)
        @name = name
		@email = email
        @voucher = voucher
        app_name = System::Config.first.name_sort
        mail(to: @email, subject: app_name+' | '+t("app_mailer_voucher"))
    end

end
