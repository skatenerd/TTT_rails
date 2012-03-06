module PagesHelper
  def td(text)
    content_tag(:td,text)
  end

  def row(contents)
    body=""
    contents.each do |text|
      body<<td(text)
    end
    content_tag(:tr,body.html_safe)
  end

  def table(rows)
    #content_tag(:table,content_tag(:tr, td("fizz")))
    body=""
    rows.each do |currow|
      body<<row(currow)
    end
    content_tag(:table,body.html_safe)
  end
end
