class Issue < ApplicationRecord
  belongs_to :magazine
  has_many :articles

  validates_presence_of :year
end
