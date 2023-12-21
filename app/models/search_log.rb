class SearchLog < ApplicationRecord
  def self.write_log(params, pagy)
    create!(
      search_terms: params,
      result_count: pagy.count
    )
  end
end
