# encoding: utf-8

class UploadUploader < CarrierWave::Uploader::Base

    storage :file

    @user_logged
    @fname
    @name_original
	# storage :fog

	# Override the directory where uploaded files will be stored.
	# This is a sensible default for uploaders that are meant to be mounted:
	def store_dir
		"public/data/"
	end

	def userId id
		@user_logged = id
	end
	# Provide a default URL as a default if there hasn't been a file uploaded:
	# def default_url
	#   # For Rails 3.1+ asset pipeline compatibility:
	#   # ActionController::Base.helpers.asset_path("fallback/" + [version_name, "default.png"].compact.join('_'))
	#
	#   "/images/fallback/" + [version_name, "default.png"].compact.join('_')
	# end

	# Process files as they are uploaded:
	# process :scale => [200, 300]
	#
	# def scale(width, height)
	#   # do something
	# end

	# Create different versions of your uploaded files:
	# version :thumb do
	#   process :resize_to_fit => [50, 50]
	# end

	# Add a white list of extensions which are allowed to be uploaded.
	# For images you might use something like this:
	def extension_white_list
		%w(png jpg jpeg pdf svg doc docx txt ppt pptx zip rar xlsx css xml sql gz tar xls csv)
	end

	def cache_dir
		'/tmp/domum-file-cache'
	end

  def filename
		if @user_logged
			@fname = "#{@user_logged}_#{Time.now.year}#{Time.now.month}#{Time.now.day}#{Time.now.hour}#{Time.now.min}#{Time.now.sec}_#{original_filename}" if original_filename.present?
		else
			@fname = "#{Time.now.year}#{Time.now.month}#{Time.now.day}#{Time.now.hour}#{Time.now.min}#{Time.now.sec}_#{original_filename}" if original_filename.present?
		end

	end

  def get_original_name
    if original_filename.present?
      original_filename
    else
      'none'
    end
  end

	def get_filename
		return @fname
	end

	# Override the filename of the uploaded files:
	# Avoid using model.id or version_name here, see uploader/store.rb for details.
	# def filename
	#   "something.jpg" if original_filename
	# end

	protected
	def secure_token
		var = :"@#{mounted_as}_secure_token"
		model.instance_variable_get(var) or model.instance_variable_set(var, SecureRandom.uuid)
	end



end
