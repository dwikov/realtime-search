require 'rails_helper'

RSpec.describe ActivitiesHelper, type: :helper do
  describe "#check_if_similar" do
    it "should return true if query is similar to previous query" do
      query = "where is emil hajric going?"
      processed_latest_query = helper.process_query("where did emil hajric go to?")
      expect(check_if_similar(query, processed_latest_query)).to be true
    end

    it "should return false if query is not similar to previous query" do
      query = "where is emil hajric going?"
      processed_latest_query = helper.process_query("where is mohamad dwik going to?")
      expect(check_if_similar(query, processed_latest_query)).to be false
    end
  end

  describe "#process_query" do
    it "should remove signs and stop words then stemm query string" do
      query = "where is Emil hajric going?"
      processed_query = "emil hajric go"
      expect(helper.process_query(query)).to eq(processed_query)
    end
  end

  describe "#filter_stopwords" do
    it "should remove stop words from query string" do
      query = "how is emil hajric"
      filtered_query = "emil hajric"
      expect(helper.filter_stopwords(query)).to eq(filtered_query)
    end
  end

  describe "#stemm" do
    it "should stemm query string" do
      query = "going tested destiny"
      stemmed_query = "go test destini"
      expect(helper.stemm(query)).to eq(stemmed_query)
    end
  end  
end