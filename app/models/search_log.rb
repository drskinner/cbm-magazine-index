class SearchLog < ApplicationRecord
  include Searchable

  scope :zero_results, ->(_) { where(result_count: 0) }

  def self.write_log(params, pagy)
    create!(
      search_terms: params,
      result_count: pagy.count
    )
  end

  #
  # Logging admin support methods for a human-friendly display.
  #
  def search_url
    "/public/search?" + search_params.to_query
  end

  def search_params
    search_terms.slice(
      'author_contains',
      'by_article_type',
      'by_language',
      'by_magazine_id',
      'by_year',
      'for_machine',
      'has_all_tags',
      'has_text'
    ).compact
  end

  def search_params_display
    search_params.map do |key, value|
      label = I18n.t("search.#{key}")
      display_value = format_search_value(key, value)
      [label, display_value]
    end
  end

  def search_summary
    summary = [].tap do |p|
      p << Magazine.find_by(id: search_params['by_magazine_id'])&.to_s if search_params['by_magazine_id'].present?
      p << "Year: #{search_params['by_year']}" if search_params['by_year'].present?
      p << "Type: #{format_search_value('by_article_type', search_params['by_article_type'])}" if search_params['by_article_type'].present?
      p << "\"#{search_params['has_text']}\"" if search_params['has_text'].present?
      p << "Author: #{search_params['author_contains']}" if search_params['author_contains'].present?
      p << "Language: #{Language.find_by(id: search_params['by_language']).to_s}" if search_params['by_language'].present?
      p << "Machine: #{format_search_value('for_machine', search_params['for_machine'])}" if search_params['for_machine'].present?
      p << "Tags: #{format_search_value('has_all_tags', search_params['has_all_tags'])}" if search_params['has_all_tags'].present?
    end.compact_blank.join(', ')

    summary.presence || '(empty search)'
  end

  private

  def format_search_value(key, value)
    case key
    when 'by_magazine_id'
      Magazine.find_by(id: value)&.to_s || value
    when 'by_article_type'
      Classification.find_by(id: value)&.to_s || value
    when 'by_language'
      Language.find_by(id: value)&.to_s || value
    when 'for_machine'
      Machine.where(id: value).pluck(:name).join(', ') || value
    when 'has_all_tags'
      Tag.where(id: value.split(',')).pluck(:name).join(', ')
    else
      value
    end
  end
end
