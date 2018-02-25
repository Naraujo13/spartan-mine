class ActiveRecord::Base
  # this method search the description field
  # if not exist the field this method need overlapped
  # on contoller
  def self.search(search)
    if search
      self.where("description like ?", "%#{search}%").order(updated_at: :desc)
    else
      self.all.order(updated_at: :desc)
    end
  end
end
