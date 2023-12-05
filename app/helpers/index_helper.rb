module IndexHelper
  def pagination_info(page:, page_size:, full_count:)
    return 'No records.' if full_count.zero?

    page ||= 1
    first_record = (page.to_i - 1) * page_size + 1
    last_record = first_record + page_size - 1
    last_record = full_count if last_record > full_count

    "Displaying #{first_record}&ndash;#{last_record} of #{full_count} records."
  end

  def svg(icon)
    file_path = "#{Rails.root}/app/assets/images/#{icon}.svg"
    return File.read(file_path).html_safe if File.exist?(file_path)
    '(not found)'
  end
end
