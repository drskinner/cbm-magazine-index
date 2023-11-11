module StatusHelper
  def issues_registered(magazine)
    magazine.issues&.count
  end

  def issues_read(magazine)
    Issue.joins(:articles).where(magazine_id: magazine.id).uniq&.count
  end

  def articles_catalogued(magazine)
    Article.joins(:issue).where(issue: { magazine_id: magazine.id })&.count
  end

  def percent_complete(magazine)
    if issues_read(magazine).zero?
      '0.00'
    else
      '%.2f' % (issues_read(magazine).to_f / issues_registered(magazine).to_f * 100)
    end
  end

  def overall_percent_complete
    '%.2f' % (Issue.joins(:articles).uniq&.count.to_f / Issue.all.count.to_f * 100)
  end
end
