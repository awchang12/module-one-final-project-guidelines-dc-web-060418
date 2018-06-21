require 'spec_helper'
require_relative '../app/models/user.rb'

describe "User" do
let(:user) {User.new}

  describe "#save_hike_from_search" do
    it "creates new instance of SaveHike" do
      allow(user).to receive(:gets).and_return("yes", "4")
      expect {user.save_hike_from_search}.to output("Would you like to save a hike? yes or no?\n\nPlease enter a Hike ID\n\nThis hike has been saved to your Hikes\n\n").to_stdout
    end
  end

  describe "#save_hike_from_search" do
    it "creates new instance of SaveHike" do
      allow(user).to receive(:gets).and_return("j;alskdf","yes", "4")
      expect {user.save_hike_from_search}.to output("Would you like to save a hike? yes or no?\n\nPlease enter a valid answer\n\nWould you like to save a hike? yes or no?\n\nPlease enter a Hike ID\n\nThis hike has been saved to your Hikes\n\n").to_stdout
    end
  end

end
