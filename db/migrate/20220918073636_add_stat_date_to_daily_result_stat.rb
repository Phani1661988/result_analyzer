class AddStatDateToDailyResultStat < ActiveRecord::Migration[6.0]
  def change
    add_column :daily_result_stats, :stat_date, :string
  end
end
