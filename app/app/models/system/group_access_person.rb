class System::GroupAccessPerson < ActiveRecord::Base
  belongs_to :users
  belongs_to :system_group_access
end
