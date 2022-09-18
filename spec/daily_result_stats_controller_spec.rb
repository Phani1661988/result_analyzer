require "rails_helper"

RSpec.describe DailyResultStatsController, :type => :controller do
  describe "Calculate Daily Stats" do
    before(:each) do
      create(:result, marks: 99)
      create(:result, marks: 102)
      create(:result, marks: 39)
      post :calculate_daily_result_stats
    end
    it "has a 200 status code" do
      expect(response.status).to eq(200)
    end

    it "has content type application/json" do
      expect(response.content_type).to eq("application/json; charset=utf-8")
    end
  end

  describe "Getdaily stats" do
    before(:each) do
      create(:result, marks: 199)
      create(:result, marks: 202)
      create(:result, marks: 49)
      post :calculate_daily_result_stats
    end
    it "has a 200 status code" do
      get :fetch_daily_stats
      expect(response.status).to eq(200)
    end

    it "responds with 200 status with list of daily results stats when data is available for a particular date" do
      get :fetch_daily_stats, params: { date: Date.today.to_s}
    end

    it "response with 200 status with list of daily results for a current day if the date param is not provided" do
      get :fetch_daily_stats
      response_body = JSON.parse(response.body).first
      expect(response_body["subject"].should == "English")
    end
  end
end