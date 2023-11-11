class Magazine < ApplicationRecord
  has_many :issues

  validates_presence_of :slug, :name, :alpha_guide
end
