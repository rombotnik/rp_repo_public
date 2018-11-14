Time::DATE_FORMATS[:time_only_today] = ->(time) do
  st = Time.now.beginning_of_day
  nd = Time.now.end_of_day

  case 
  when time.between?(st, nd)
    time.strftime('%l:%M%P')
  when time.between?(st - 7.days, nd)
    time.strftime('%l:%M%P on %A')
  else 
    time.strftime('%l:%M%P on %B %e, %Y')
  end
end
