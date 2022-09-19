class MonthlyAveragesController < ApplicationController
	SUBJECTS = ['Science', 'Social', 'English', 'Physics', 'Mathematics']
	def calculate_monthly_stats
	 calculate_monthly_low_monthly_high_count
	end

	def fetch_monthly_stats
	  	start_date = Date.today.beginning_of_month
		end_date = start_date.next_week(:wednesday)+2.week-2
        results = MonthlyAverage.where("created_at::Date BETWEEN ? AND ?", start_date, end_date)
        return render json: {error: "No stats exist for this month"} if results.blank?
        render json: results
	end

	 private

	 def calculate_monthly_low_monthly_high_count
	  	start_date = Date.today.beginning_of_month
		end_date = start_date.next_week(:wednesday)+2.week-2
	   return render json: {error: "No stats exist for this month"} if Result.where("created_at::Date BETWEEN ? AND ?", start_date, end_date).blank?
	   	dates_array = [start_date.to_s, (start_date-1).to_s, (start_date-2).to_s]
		results = Result.where("created_at::Date BETWEEN ? AND ?", start_date, end_date)
	    monthly_stats_array = calculate_monthly_aggregates(results, start_date, end_date, dates_array)
		 	monthly_stats_array.each do |stat|
		 		MonthlyAverage.create(stat)
		 	end
	 end

	 def calculate_monthly_aggregates(results, start_date, end_date, dates_array)
	 	MonthlyAverage.where("created_at::Date BETWEEN ? AND ?", start_date, end_date).destroy_all

	 	stats_array = Array.new
	 	dates_array.each do |start_date|
	 		count = 0
	 			start_date = start_date.to_date
			 	SUBJECTS.each do |subject|
			 		next if results.where(subject: subject).blank?
			 		subject_hash = Hash.new
			 		subject_hash['subject'] = subject
			 		subject_hash['monthly_result_count_used'] = results.where(subject: subject).where("created_at::Date BETWEEN ? AND ?", start_date, end_date).count
			        subject_hash['monthly_avg_high'] = monthly_average_high(start_date, end_date)
			        subject_hash['monthly_avg_low'] = monthly_average_low(start_date, end_date)
			        stats_array.push(subject_hash)
			 	end
			 	return stats_array if results.where("created_at::Date BETWEEN ? AND ?", start_date, end_date).count >= 10
	 	end
	 end

	 def monthly_average_high(start_date, end_date)
	 	marks_array = DailyResultStat.where("created_at::Date BETWEEN ? AND ?", start_date, end_date).pluck(:daily_high)
	 	max_month_average = marks_array.sum/marks_array.size unless marks_array.empty?
	    max_month_average.round(2)
	 end

	  def monthly_average_low(start_date, end_date)
	 	marks_array = DailyResultStat.where("created_at::Date BETWEEN ? AND ?", start_date, end_date).pluck(:daily_low)
	 	min_month_average = marks_array.sum/marks_array.size unless marks_array.empty?
	 	min_month_average.round(2)
	 end

end

