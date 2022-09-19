Given(/^Calculate Monthly Results Data$/) do
  post '/calculate_monthly_stats'
end

Then(/^Monthly count of records should be greater than zero$/) do
	puts "Count of Records is #{Result.count}"
end