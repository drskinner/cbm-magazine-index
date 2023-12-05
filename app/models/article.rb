class Article < ApplicationRecord
  include Searchable

  belongs_to :issue

  scope :by_sequence, ->(sequence) { joins(:issue).where(issue: { sequence: sequence }) }
  scope :by_magazine_id, ->(id) { joins(:issue).where(issue: { magazine_id: id }) }
  scope :by_year, ->(year) { joins(:issue).where(issue: { year: year }) }
end
