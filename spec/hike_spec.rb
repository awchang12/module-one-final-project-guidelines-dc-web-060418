require 'spec_helper'
require_relative '../app/models/hike.rb'

describe "Hike" do

  describe ".search_hikes_by_length" do
    it "returns an array of hikes within a given range" do
      expect(Hike.search_hikes_by_length(2.7, 2.8)).to include(Hike.find_by_id(17))
    end
  end

  describe ".search_hikes_by_difficulty" do
    it "returns an array of hikes given a difficulty level" do
      expect(Hike.search_hikes_by_difficulty("greenBlue")).to include(Hike.find_by_id(4), Hike.find_by_id(6))
    end
  end

end
