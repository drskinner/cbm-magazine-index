class Tag < ApplicationRecord

  validates_presence_of :name

  def self.collection
    Tag.all.order(alpha_guide: :asc).map { |t| [t.name, t.id] }
  end

  def to_s
    name
  end
end
