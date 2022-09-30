require 'rails_helper'
require 'database_cleaner/mongoid'
require 'rake'

DatabaseCleaner.strategy = :deletion
Rails.application.load_tasks

RSpec.describe SearchController, type: :controller do
  before :each do
    Rake::Task['db:mongoid:remove_undefined_indexes'].invoke
    Rake::Task['db:mongoid:create_indexes'].invoke
    DatabaseCleaner.start
  end

  after :each do
    DatabaseCleaner.clean
  end

  describe "POST #match_all" do
    let(:query) { "mystr" }

    it "returns http success" do
      post :match_all, :params => { :query => query }
      expect(response).to have_http_status(:ok)
    end

    it "renders array of result articles json" do
      Article.new(title: 'title', body: 'mystr is somthing').save
      post :match_all, :params => { :query => query }
      expect(json[0]['title']).to eq('title')
    end
  end
end