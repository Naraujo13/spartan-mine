class Mediafile < ActiveRecord::Base

    mount_uploader :file, SpartanUploader
    
    belongs_to :user
    belongs_to :item
    
end
