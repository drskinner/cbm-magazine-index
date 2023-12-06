class Article < ApplicationRecord
  include Searchable
  include ActionView::Helpers::TextHelper

  belongs_to :classification
  belongs_to :issue
  belongs_to :language, optional: true

  scope :author_contains, ->(name) { where('author ILIKE ?', "%#{name}%") }
  scope :by_article_type, ->(id) { where(classification_id: id) }
  scope :by_language, ->(id) { where(language_id: id) }
  scope :by_magazine_id, ->(id) { joins(:issue).where(issue: { magazine_id: id }) }
  scope :by_sequence, ->(sequence) { joins(:issue).where(issue: { sequence: sequence }) }
  scope :by_year, ->(year) { joins(:issue).where(issue: { year: year }) }
  scope :for_machine, ->(id) { where('machine_ids && ARRAY[?]', id.to_i) }
  # scope :for_machines, ->(ids) { where('machine_ids && ARRAY[?]', ids.map(&:to_i)) }
  scope :has_text, ->(text) { where('description ILIKE ? OR blurb ILIKE ? OR title ILIKE ?', "%#{text}%", "%#{text}%", "%#{text}%") }

  attr_accessor :magazine_id

  validates_presence_of :title, :author, :issue_id, :page, :classification_id, :description

  def to_s
    title
  end

  def machine_ids=(machine_ids)
    super(machine_ids.reject(&:blank?))
  end

  def classification_id_display
    classification.name
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

  # These results methods could easily be decorators
  def author_for_results
    truncate(author, length: 48)
  end

  def description_for_results
    result_string = description&.gsub!('<i>', '')&.gsub!('</i>', '')
    truncate("#{blurb} #{result_string || description}",
             length: 108,
             omission: " ... #{description[-24, 24]}")
  end

  def issue_for_results
    sanitize "<i>#{issue.magazine}</i> #{issue.friendly_name}"
  end

  def title_for_results
    truncate(title, length: 85)
  end
end
