class System::GroupAccessProgram < ActiveRecord::Base
  belongs_to :system_group_accesses
  belongs_to :system_programs
end
