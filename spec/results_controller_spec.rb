require "rails_helper"

RSpec.describe ResultsController, :type => :controller do
  describe "POST store_data" do
    before(:each) do
      post :store_data
    end
    it "has a 200 status code" do
      expect(response.status).to eq(200)
    end

    it "has content type application/json" do
      expect(response.content_type).to eq("application/json; charset=utf-8")
    end
  end
end