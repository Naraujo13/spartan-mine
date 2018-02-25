class Example::Tag < ActiveRecord::Base
  validates :title, presence: true, allow_blank: false
  belongs_to :post
  def self.search(search)
    if search
      self.where("title like ?", "%#{search}%").order(updated_at: :desc)
    else
      self.all.order(updated_at: :desc)
    end
  end
end
