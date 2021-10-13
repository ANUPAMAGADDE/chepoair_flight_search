
module UtilitiesModule



  def navigate_to url
    @browser.goto url
    sleep 2
  end



  def cal_date no_of_days
    (Time.now + 24*60*60*no_of_days).strftime("%-d %B %Y")
  end

end