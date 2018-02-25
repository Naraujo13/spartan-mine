class Item < ActiveRecord::Base

    belongs_to :collection
    has_many :mediafiles
    accepts_nested_attributes_for :mediafiles

end
