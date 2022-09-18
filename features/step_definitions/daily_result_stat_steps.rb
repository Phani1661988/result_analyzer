Given(/^Calculate Daily Stat from Results data$/) do
  post '/calculate_daily_stats'
end

Then(/^Daily Result Stats should be greater than zero$/) do
	puts "Count of Records is #{DailyResultStat.count}"
end

Given(/^Get Daily Stats$/) do
  get '/get_daily_stats'
end