class ApiKeys < ApplicationRecord
  scope :enabled, -> { where(enabled: true) }
end
