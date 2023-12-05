class Article < ApplicationRecord
  include Searchable

  belongs_to :classification
  belongs_to :issue
  belongs_to :language, optional: true

  scope :by_sequence, ->(sequence) { joins(:issue).where(issue: { sequence: sequence }) }
  scope :by_magazine_id, ->(id) { joins(:issue).where(issue: { magazine_id: id }) }
  scope :by_year, ->(year) { joins(:issue).where(issue: { year: year }) }

  attr_accessor :magazine_id

  validates_presence_of :title, :author, :issue_id, :page, :classification_id, :description

  def to_s
    title
  end

  def machine_ids=(machine_ids)
    super(machine_ids.reject(&:blank?))
  end

  def language_id_display
    language&.name
  end

  def machine_ids_display
    Machine.where(id: machine_ids).pluck(:name).join(', ')
  end

  def magazine_id_display
    issue.magazine.to_s
  end

  def tag_ids_display
    Tag.where(id: tag_ids).pluck(:name).join(', ')
  end
end
