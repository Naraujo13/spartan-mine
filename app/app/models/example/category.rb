class Example::Category < ActiveRecord::Base
    validates :description, presence: true, allow_blank: false
end
