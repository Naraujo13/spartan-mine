class System::AccessTo < ActiveRecord::Base
  belongs_to :user
  belongs_to :program
end
