class Collection < ActiveRecord::Base

    belongs_to :museum
    has_many :items
       

end
