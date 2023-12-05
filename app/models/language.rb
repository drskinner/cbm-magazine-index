class Language < ApplicationRecord

  has_many :articles
  
  validates_presence_of :name, :position

  def self.collection
    Language.all.order(position: :asc).map { |l| [l.name, l.id] }
  end

  def to_s
    name
  end
end
