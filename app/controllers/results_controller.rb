class ResultsController < ApplicationController
	def store_data
		results = import_data
		render json: { result_data: results }
	end

private

	def import_data
	result1 = Result.create(subject: 'Science', marks: rand(10..300))
	result2 = Result.create(subject: 'Social', marks: rand(10..300))
	result3 = Result.create(subject: 'English', marks: rand(10..300))
	result4 = Result.create(subject: 'Physics', marks: rand(10..300))
	result5 = Result.create(subject: 'Mathematics', marks: rand(10..300))

		[result1, result2, result3, result4, result5].each do |result|
			12.times do |i|
				Result.create(subject: result.subject, marks: rand(10..300))
			end
		end
	 Result.all
	end
end


# Result.where(created_at: Date.parse("2022-09-17").all_day).count

# DateTime.now.strftime("%Y-%m-%d)

# Result.where(subject: 'Science').count

# Result.where(subject: 'Science').order(marks: :desc).pluck(:marks)