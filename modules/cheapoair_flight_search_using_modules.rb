
require 'watir'
require_relative 'modules/utilities_module'
require_relative 'modules/cheapoair_flight_search_module'

include UtilitiesModule
include CheapoairFlightSearchModule


@browser = Watir::Browser.new :chrome
navigate_to 'www.cheapoair.com'
search_dep_airport 'Columbus', 'CMH - Columbus, Ohio'
search_arr_airport 'Cleveland', 'CLE - Cleveland, Ohio'
choose_dep_date 3
choose_arr_date 5
search_flights
verify_flights_displayed?
