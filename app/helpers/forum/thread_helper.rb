module Forum::ThreadHelper
  def format_date(datetime)
    if datetime.to_date == DateTime.now.to_date
      "Today, #{datetime.strftime '%H:%M'}"
    end
    datetime.strftime('%d/%B/%Y %H:%M')
  end
end