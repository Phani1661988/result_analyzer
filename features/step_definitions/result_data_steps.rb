Given(/^Receive result data from MSM$/) do
  post '/results_data'
end

Then(/^Count of records should be greater than zero$/) do
	puts "Count of Records is #{Result.count}"
end