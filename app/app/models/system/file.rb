class System::File < ActiveRecord::Base
  belongs_to :user
  def self.search(search)
    if search
      self.where("name like ?", "%#{search}%").order(created_at: :desc)
    else
      self.all
    end
  end
end
