require 'rails_helper'
require 'database_cleaner/mongoid'


DatabaseCleaner.strategy = :deletion

RSpec.describe ActivitiesController, type: :controller do
  before :each do
    DatabaseCleaner.start
  end

  after :each do
    DatabaseCleaner.clean
  end

  before :each do
    allow_any_instance_of(ApplicationHelper).to receive(:verify_and_decrypt_session_cookie) { {"session_id" => "MyString"} }
  end

  describe "GET #index" do
    let(:activity) { create :activity }

    before :each do
      request.headers["HTTP_COOKIE"] = "_realtime_search_session=#{activity.user_session}"
      
      get :index
    end

    it "returns http success" do
      expect(response).to have_http_status(:ok)
    end

    it "renders unique queries count json" do
      expect(json).to eq([{"_id"=>activity.query, "count"=>1}])
    end
  end

  describe "POST #create" do
    context "when invalid" do
      let (:activity) { build :activity, query: '' }

      it "returns http success" do
        post :create, :params => { :activity => activity.attributes }
        expect(response).to have_http_status(:ok)
      end

      it "renders empty unique queries count json" do        
        post :create, :params => { :activity => activity.attributes }
        expect(json).to eq([])
      end
    end

    context "when valid" do
      let (:activity) { build :activity}
      
      it "adds activity & renders unique queries count json" do 
        request.headers["HTTP_COOKIE"] = "_realtime_search_session=#{activity.user_session}"
        post :create, :params => { :activity => activity.attributes }

        expect(json).to eq([{"_id"=>activity.query, "count"=>1}])
      end

    end
  end
end