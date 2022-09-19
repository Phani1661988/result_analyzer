class CreateMonthlyAverages < ActiveRecord::Migration[6.0]
  def change
    create_table :monthly_averages do |t|
      t.text :stat_date
      t.text :subject
      t.float :monthly_avg_low
      t.float :monthly_avg_high
      t.integer :monthly_result_count_used

      t.timestamps
    end
  end
end