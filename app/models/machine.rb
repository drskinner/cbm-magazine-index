class Machine < ApplicationRecord

  validates_presence_of :name, :position

  def self.collection
    Machine.all.order(position: :asc).map { |m| [m.name, m.id] }
  end

  def to_s
    name
  end
end
