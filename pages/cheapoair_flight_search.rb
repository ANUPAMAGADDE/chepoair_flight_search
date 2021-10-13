require 'watir'

browser = Watir::Browser.new :chrome
browser.goto 'www.cheapoair.com'

sleep 2

# browser.link(pages: 'suggestion-box__clear icon', index: 0).click if browser.link(pages: 'suggestion-box__clear icon', index: 0).present?
clear_dep_search = browser.link(class: 'suggestion-box__clear icon', index: 0)
clear_dep_search.click if clear_dep_search.present?
browser.text_field(id: 'from0').set "Columbus"
sleep 2
browser.ul(class: 'suggestion-box__list autoSuggest__list').lis.each do |all_airports|
  p all_airports.text
  if all_airports.text.include? 'CMH - Columbus, Ohio'
    all_airports.click
    break
  end
end

sleep 2
# browser.link(pages: 'suggestion-box__clear icon', index: 1).click if browser.link(pages: 'suggestion-box__clear icon', index: 1).present?
clear_arr_search = browser.link(class: 'suggestion-box__clear icon', index: 1)
clear_arr_search.click if clear_arr_search.present?

browser.text_field(id: 'to0').set "Cleveland"
sleep 2
browser.ul(class: 'suggestion-box__list autoSuggest__list', index: 1).lis.each do |all_airports|
  p all_airports.text
  if all_airports.text.include? 'CLE - Cleveland, Ohio'
    all_airports.click
    break
  end
end


browser.div(class: 'col-6 calendarDepart').click
browser.link(aria_label: '20 October 2021').click

browser.div(class: 'col-6 calendarReturn').click
browser.link(aria_label: '30 October 2021').click

browser.button(id: 'searchNow').click

sleep 8

fail "Flight Search results NOT found" unless browser.div(class: 'filters--content col-12 p-0').text.include? 'results found'


p "done"
