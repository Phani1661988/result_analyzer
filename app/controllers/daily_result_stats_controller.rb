class DailyResultStatsController < ApplicationController
	SUBJECTS = ['Science', 'Social', 'English', 'Physics', 'Mathematics']
	def calculate_daily_result_stats
		calculate_daily_low_daily_high_count
	end

	def fetch_daily_stats
		if params[:date].present?
			render json: DailyResultStat.where(stat_date: params[:date])
		else
			render json: DailyResultStat.where(created_at: Date.parse(DateTime.now.strftime("%Y-%m-%d")).all_day)
		end
	end

 private

	 def calculate_daily_low_daily_high_count
	 	return render json: {error: "No stats exist for today"} if Result.all.blank?

	 	stats_array = calculate_subjectwise_aggregates(Result.all)
	 	stats_array.each do |stat|
	 		DailyResultStat.create(stat)
	 	end
	 	render json: {daily_stats: DailyResultStat.all}
	 end

	 def calculate_subjectwise_aggregates(results)
	 	DailyResultStat.destroy_all
	 	stats_array = Array.new
	 	date = Date.parse(DateTime.now.strftime("%Y-%m-%d"))
	 	SUBJECTS.each do |subject|
	 		next if results.where(subject: subject).blank?
	 		subject_hash = Hash.new
	 		subject_hash['subject'] = subject
	 		subject_hash['daily_volume'] = results.where(subject: subject, created_at: date.all_day).count
            subject_hash['daily_high'] = results.where(subject: subject, created_at: date.all_day).order(marks: :desc).pluck(:marks).first
            subject_hash['daily_low'] = results.where(subject: subject, created_at: date.all_day).order(marks: :asc).pluck(:marks).first
            subject_hash['stat_date'] = date.to_s
            stats_array.push(subject_hash)
	 	end
	 	stats_array
	 end
end
