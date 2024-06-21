module IssueHelper
  def archive_base_url(issue)
    # useless local variables for readability:
    my_slug = issue.magazine.slug
    my_suffix = issue.magazine.archive_suffix.to_s

    "cbm_magazine_index-#{my_slug}#{my_suffix}/#{my_slug}"
  end

  def archive_slug(issue)
    # useless local variables for readability:
    my_slug = issue.magazine.slug
    my_sequence = issue.special_slug || format('%02i', issue.sequence)
    my_month = issue.month.blank? ? '' : format('%02i', issue.month)

    "#{issue.year}/#{my_slug}-#{my_sequence}-#{issue.year}#{my_month}"
  end

  def article_page(page)
    "page/#{page}/mode/2up"
  end

  def archive_download_link(issue)
    "https://archive.org/download/#{archive_base_url(issue)}/#{archive_slug(issue)}.pdf"
  end

  def archive_jpeg_link(issue)
    "https://archive.org/download/#{archive_base_url(issue)}/#{archive_slug(issue)}_jp2.zip"
  end

  def archive_ocr_link(issue)
    "https://archive.org/stream/#{archive_base_url(issue)}/#{archive_slug(issue)}_djvu.txt"
  end

  def archive_view_article_link(issue, page)
    "https://archive.org/details/#{archive_base_url(issue)}/#{archive_slug(issue)}/#{article_page(page)}"
  end

  def archive_view_issue_link(issue)
    "https://archive.org/details/#{archive_base_url(issue)}/#{archive_slug(issue)}?view=theater"
  end

  def cover_image_url(issue)
    return 'covers/blank.jpg' if issue.blank?

    if issue.special_slug
      "covers/#{issue.magazine.slug}/#{issue.magazine.slug}-#{issue.special_slug}.jpg"
    else
      "covers/#{issue.magazine.slug}/#{issue.magazine.slug}-#{format('%02i', issue.sequence)}.jpg"
    end
  end
end
