class Example::Post < ActiveRecord::Base
  def self.search(search)
    if search
      self.where("title like ?", "%#{search}%").order(updated_at: :desc)
    else
      self.all.order(updated_at: :desc)
    end
  end
end
