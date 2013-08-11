module ApplicationHelper
  def format_date(date)
    if date
      date.strftime('%d.%m.%Y')
    else
      '----'
    end
  end

  def select_model_date_range(model)
    (model.begin_date..model.end_date).map {|date| [format_date(date), date]}
  end
end
