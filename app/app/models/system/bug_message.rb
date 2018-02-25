class System::BugMessage < ActiveRecord::Base
  belongs_to :system_bugs
  def self.search(search)
    if search
      self.where("message like ?", "%#{search}%").order(created_at: :desc)
    else
      self.all
    end
  end
end
