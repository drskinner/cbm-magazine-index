class Classification < ApplicationRecord

  has_many :articles
  
  validates_presence_of :name, :position

  def self.collection
    Classification.all.order(position: :asc).map { |c| [c.name, c.id] }
  end

  def to_s
    name
  end
end
