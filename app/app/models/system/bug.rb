class System::Bug < ActiveRecord::Base
  belongs_to :bug_status
  def self.search(search)
    if search
      self.where("problem like ?", "%#{search}%").order(created_at: :desc)
    else
      self.all
    end
  end
end
