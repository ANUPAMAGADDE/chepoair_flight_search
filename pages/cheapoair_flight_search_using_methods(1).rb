
require 'watir'


def navigate_to url
  @browser.goto url
end

def search_dep_airport dep_city, dep_airport
  # @browser.link(pages: 'suggestion-box__clear icon', index: 0).click if @browser.link(pages: 'suggestion-box__clear icon', index: 0).present?
  clear_dep_search = @browser.link(class: 'suggestion-box__clear icon', index: 0)
  clear_dep_search.click if clear_dep_search.present?
  @browser.text_field(id: 'from0').set dep_city
  sleep 1
  @browser.ul(class: 'suggestion-box__list autoSuggest__list').lis.each do |all_airports|
    p all_airports.text
    if all_airports.text.include? dep_airport
      all_airports.click
      break
    end
  end
end

def search_arr_airport arr_city, arr_airport
  # @browser.link(pages: 'suggestion-box__clear icon', index: 1).click if @browser.link(pages: 'suggestion-box__clear icon', index: 1).present?
  clear_arr_search = @browser.link(class: 'suggestion-box__clear icon', index: 1)
  clear_arr_search.click if clear_arr_search.present?

  @browser.text_field(id: 'to0').set arr_city
  sleep 1
  @browser.ul(class: 'suggestion-box__list autoSuggest__list', index: 1).lis.each do |all_airports|
    p all_airports.text
    if all_airports.text.include? arr_airport
      all_airports.click
      break
    end
  end
end

def cal_date no_of_days
  (Time.now + 24*60*60*no_of_days).strftime("%-d %B %Y")
end

def choose_dep_date no_of_days
  exact_date = cal_date no_of_days
  @browser.div(class: 'col-6 calendarDepart').click
  @browser.link(aria_label: exact_date).click
end

def choose_arr_date no_of_days
  exact_date = cal_date no_of_days
  @browser.div(class: 'col-6 calendarReturn').click
  @browser.link(aria_label: exact_date).click
end

def search_flights
  @browser.button(id: 'searchNow').click
end

def verify_flights_displayed?
  filter_section = @browser.div(class: 'filters--content col-12 p-0')
  @browser.wait_until(45) { filter_section.exist? }
  fail "Flight Search results NOT found" unless filter_section.text.include? 'results found'
end

@browser = Watir::Browser.new :chrome
navigate_to 'www.cheapoair.com'
search_dep_airport 'Columbus', 'CMH - Columbus, Ohio'
search_arr_airport 'Cleveland', 'CLE - Cleveland, Ohio'
choose_dep_date 3
choose_arr_date 5
search_flights
verify_flights_displayed?