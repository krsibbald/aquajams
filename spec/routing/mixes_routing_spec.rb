require "rails_helper"

RSpec.describe MixesController, type: :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/mixes").to route_to("mixes#index")
    end

    it "routes to #new" do
      expect(:get => "/mixes/new").to route_to("mixes#new")
    end

    it "routes to #show" do
      expect(:get => "/mixes/1").to route_to("mixes#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/mixes/1/edit").to route_to("mixes#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/mixes").to route_to("mixes#create")
    end

    it "routes to #update via PUT" do
      expect(:put => "/mixes/1").to route_to("mixes#update", :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/mixes/1").to route_to("mixes#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/mixes/1").to route_to("mixes#destroy", :id => "1")
    end

  end
end
