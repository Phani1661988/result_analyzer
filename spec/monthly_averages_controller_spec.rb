require "rails_helper"

RSpec.describe MonthlyAveragesController, :type => :controller do
  describe "Calculate Monthly Stats" do
    it "has a 200 status code" do
      create(:daily_result_stat, subject: 'Mathematics')
      create(:daily_result_stat, subject: 'English')
      create(:daily_result_stat, subject: 'Mathematics')
      create(:daily_result_stat, subject: 'English')
      create(:daily_result_stat, subject: 'Mathematics')
      create(:daily_result_stat, subject: 'English')
      post :calculate_monthly_stats
      expect(response.status).to eq(200)
    end

    it "throws No stats exist for this month error if no Results present" do
      post :calculate_monthly_stats
      expect(JSON.parse(response.body)['error']).to eq("No stats exist for this month")
    end
  end

  describe "Get monthly stats" do
    it "has a 200 status code" do
      create(:daily_result_stat, subject: 'Mathematics')
      create(:daily_result_stat, subject: 'English')
      create(:daily_result_stat, subject: 'Mathematics')
      create(:daily_result_stat, subject: 'English')
      create(:daily_result_stat, subject: 'Mathematics')
      create(:daily_result_stat, subject: 'English')
      get :fetch_monthly_stats
      expect(response.status).to eq(200)
    end

    it "throws No stats exist for this month error if no Results present" do
      get :fetch_monthly_stats
      expect(JSON.parse(response.body)['error']).to eq("No stats exist for this month")
    end
  end
end