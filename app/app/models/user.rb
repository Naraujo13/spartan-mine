class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  attr_accessor :access_to
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :confirmable, :omniauthable, :omniauth_providers => [:facebook,:google_oauth2]
  mount_uploader :avatar, ::UploadUploader

  def self.search(search)
    if search
      self.where("first_name like ?", "%#{search}%").order(created_at: :desc)
    else
      self.all
    end
  end

  def full_name
    "#{first_name} #{last_name}"
  end

  def self.from_omniauth(auth)
      where(email: auth["info"]["email"]).first_or_create! do |user|
        user.email = auth.info.email
        user.password = Devise.friendly_token[0,20]
        user.first_name = auth.info.name   # assuming the user model has a name
        #user.avatar = auth.info.image # assuming the user model has an image
        # If you are using confirmable and the provider(s) you use validate emails,
        # uncomment the line below to skip the confirmation emails.
        # user.skip_confirmation!
      end

  end
  def self.new_with_session(params, session)
    super.tap do |user|
      if data = session["devise.facebook_data"] && session["devise.facebook_data"]["extra"]["raw_info"]
        user.email = data["email"] if user.email.blank?
      end
    end
  end
end
