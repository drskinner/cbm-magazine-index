class Magazine < ApplicationRecord
  include Searchable

  has_many :issues

  validates_presence_of :slug, :name, :alpha_guide

  scope :name_contains, ->(name) { where('name ILIKE ?', "%#{name}%") }

  def to_s
    I18n.t("magazine.name.#{slug}")
  end

  def self.collection
    Magazine.all.order(alpha_guide: :asc).map { |m| [m.to_s, m.id] }
  end
end
