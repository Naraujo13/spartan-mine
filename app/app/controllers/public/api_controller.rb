class Public::ApiController < ApplicationController

	skip_before_action :verify_authenticity_token
	
	def initialize
		@service 	= "Domum"
		@version 	= "1.1"
		@developer 	= "Glauco Roberto Munsberg"
		@lastUpdate	= Time.new
	end

	def index
		respond_to do |format|
			format.json { render json:{"actionResponse"=>"index","status"=>"200","response"=>"Great Job!Format:JSON"} }
			format.xml { render xml:{"actionResponse"=>"index","status"=>"200","response"=>"Great Job!Format:XML"} }
			format.html
		end
	end

	def isOnAir
		render json: {
			"actionResponse"=>"isOnAir",
			"status"=>"200",
		 	"response"=>"Yes, we are on Air and at the floor too!"
		}
	end

	def about
		render json:{
			"actionResponse"=>"about",
			"status"=>"200",
			"response"=>[
				"service"=>@service,
				"version"=>@version,
				"developer"=>@developer,
				"update"=>@lastUpdate,
				"status"=>
				[
					{"200"=>"Sucess(OK)"},
					{"203"=>"The server successfully processed the request (Non-Authoritative Information)"},
					{"400"=>"Invalid widget was requested (Bad Request)"},
					{"401"=>"Invalid authorization credentials (Unauthorized)"},
					{"403"=>"Invalid timestamp in Date header (Forbidden)"},
					{"404"=>"Unsupported method or format (Not Found)"},
					{"500"=>"The server cannot process the request due to a system overload. This should be a temporary condition (Server Error)"}
				]
			]
		}
	end

  def getBasicInformation
		@user = {}

		@userFinded = User.where(:email => params[:email]).limit(1)
		if(not @userFinded.blank?)
			@informations = {}
			@userFinded = @userFinded.first
      logger.debug 'Basic Information Params'
      logger.debug params

			# Horsemed informations
			@informations['examples_tags'] = Example::Tag.all
			@informations['examples_categories'] = Example::Category.all


			# person informations
      @informations['users'] = User.select('id, first_name, last_name, email, updated_at').all

			render json: {
				"actionResponse"=>"getBasicInformation",
				"status"=>"200",
			 	"response"=>@informations
			}
		else
			render json: {
				"actionResponse"=>"getBasicInformation",
				"status"=>"401",
			 	"response"=>"Oops! Token or Email wrong"
			}
		end
	end


  def setFile

    @user = {}
		@userFinded = User.where(:email => params[:email]).limit(1)
		if(not @userFinded.blank?)

			logger.info "USER OK"
            logger.debug 'File Params'
            logger.debug params
			file = Hash.new
			uploader = UploadUploader.new
			uploader.userId @userFinded.first.id
			begin
					uploader = UploadUploader.new
					uploader.userId params[:id]
					file['file'] = uploader.store!(params[:file]) #2
					file['file_name'] = uploader.get_filename #1
					file['file_original_name'] = uploader.get_original_name
					file['serial_number'] = params[:serial_number]
                    file['table'] = params[:table]
                    type = uploader.get_original_name.split('.')
                    type = type[type.length-1]
                    @system_file = System::File.new(:content_type => type, :original_name => uploader.get_original_name,:name => uploader.get_filename ,:public=>false,:user_id=>params[:id].to_i,:path=>uploader.current_path).save
			rescue Exception => e
					#@files[1] = #1
					logger.info "EXCEPTION setFile"
					logger.info e.backtrace
					file['serial_number'] = params[:serial_number]
			end

			@informations = {}
			@informations['file'] = file

			render json: {
				"actionResponse"=>"setFile",
				"status"=>"200",
			 	"response"=>@informations
			}
		else
			logger.info "USER ERROR"
			message = {}
			message['message'] = "ops! Token or Email wrong"
			render json: {
				"actionResponse"=>"setFile",
				"status"=>"401",
			 	"response"=>message
			}
		end
	end
end
