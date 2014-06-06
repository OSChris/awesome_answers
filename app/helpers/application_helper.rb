module ApplicationHelper


  def formatted_date(date)
    # content_tag(:div, date.strftime("%A, %d-%b-%Y"))
    date.strftime("%A, %d-%b-%Y")
  end


end
