class Example::PostTag < ActiveRecord::Base
  belongs_to :example_post
  belongs_to :example_tag
end
