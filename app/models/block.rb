class Block < ActiveRecord::Base
  attr_accessible :block_type, :description, :title
  validates :title, presence: true
end
