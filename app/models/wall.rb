class Wall < ActiveRecord::Base
  validates :path, uniqueness: true
end