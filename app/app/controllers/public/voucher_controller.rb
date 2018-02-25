class Public::VoucherController < ApplicationController

	def index
        logger.info 'ID'
        logger.info params[:id]
		@user = User.new
        if params[:id] != nil
            
            @voucher = System::Voucher.where(voucher: params[:id]).first

            if @voucher != nil
                
                @allowed = true
                @messenge = ""
                @user[:email] = @voucher.email
                @user[:first_name] = @voucher.first_name
                @date = @voucher.dt_expire.to_s.split(' ')[0]
                @date = @date.split('-')
                
                @date[0] = @date[0].to_i
                @date[1] = @date[1].to_i
                @date[2] = @date[2].to_i
                
                the_voucher_expired = Date.new(@date[0],@date[1],@date[2])
                
                if the_voucher_expired < Date.today
                    @allowed  = false
                    @messenge = t("voucher_expired")+" "+@date[2].to_s+"/"+@date[1].to_s+"/"+@date[0].to_s
                end
                if @voucher.voucher_used
                    @allowed  = false
                    @messenge = t("voucher_used")
                end
                
            else
                @allowed  = false
                @voucher  = System::Voucher.new
                @messenge = t("voucher_invalid")+" "+params[:id]
            end
        else
            redirect_to '/'
        end
	end
    
    def create

        @user = User.new
        user_params = params[:user]
        @redirect = true
        @voucher = System::Voucher.where(voucher: params[:voucher]).first
        if @voucher != nil
            @user.update_attributes(:first_name=>user_params[:first_name] ,:last_name=>user_params[:last_name], :admin=>false,:email=>user_params[:email],:password_confirmation=>user_params[:password_confirmation], :password=>user_params[:password])
            
            if @user.save
                System::GroupAccessPerson.create(:users_id=>@user.id, :system_group_access_id=>2)
                @voucher.voucher_used = true
                @voucher.save
                AthomeMailer.welcome_email(params[:user][:first_name], params[:user][:email], params[:user][:password]).deliver
                @allowed  = false
                @redirect = true
                @messenge = t("voucher_user_success")
            else
                @allowed  = false
                @messenge = @user.errors.full_messages.to_sentence
            end
        else
           @allowed  = false
           @voucher = System::Voucher.new
           @messenge = t("voucher_was_used")
        end
        
        render 'index.html.erb'
    end
end
