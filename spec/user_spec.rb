require 'spec_helper'
require_relative '../app/models/user.rb'

describe "User" do
let(:user) {User.new}


  describe "#save_hike_from_search" do
    it "creates new instance of SaveHike" do
      allow(user).to receive(:gets).and_return("yes", "4")
      expect {user.save_hike_from_search}.to output(/This hike has been saved to your Hikes/).to_stdout
    end
  end

  describe "#save_hike_from_search" do
    it "creates new instance of SaveHike" do
      allow(user).to receive(:gets).and_return("j;alskdf","yes", "4")
      expect {user.save_hike_from_search}.to output(/This hike has been saved to your Hikes/).to_stdout
    end
  end

  describe "#display_my_hikes" do
    it "displays a users saved hikes" do
      user1 = User.find_by_id(1)
      expect {user1.display_my_hikes}.to output(/HIKE ID: 141/).to_stdout
    end
  end


end
