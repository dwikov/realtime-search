require 'rails_helper'

RSpec.describe Activity, type: :model do
  it "is valid with valid attributes" do
    activity = Activity.new(query: "how is emil hajric?", user_session: "some string")
    expect(activity).to be_valid 
  end

  it "is invalid without a query" do
    activity = Activity.new(user_session: "some string")
    expect(activity).to be_invalid 
  end

  it "is invalid without a user_session" do
    activity = Activity.new(query: "how is emil hajric?")
    expect(activity).to be_invalid 
  end
end