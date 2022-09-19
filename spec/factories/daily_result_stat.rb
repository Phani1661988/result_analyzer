FactoryGirl.define do
  factory :daily_result_stat, class: DailyResultStat do
    daily_low { rand(11..200) }
    daily_high { rand(11..200) }
    daily_volume { rand(1..60) }
    subject "English"
  end
end