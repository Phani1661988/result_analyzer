Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  post "/results_data" => "results#store_data"

  post "/calculate_daily_stats" => "daily_result_stats#calculate_daily_result_stats"

  get "/get_daily_stats" => "daily_result_stats#fetch_daily_stats"

  post "/calculate_monthly_stats" => "monthly_averages#calculate_monthly_stats"

  get "/fetch_monthly_stats" => "monthly_averages#fetch_monthly_stats"
end
