require "rails_helper"

RSpec.describe CdsController, type: :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/cds").to route_to("cds#index")
    end

    it "routes to #new" do
      expect(:get => "/cds/new").to route_to("cds#new")
    end

    it "routes to #show" do
      expect(:get => "/cds/1").to route_to("cds#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/cds/1/edit").to route_to("cds#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/cds").to route_to("cds#create")
    end

    it "routes to #update via PUT" do
      expect(:put => "/cds/1").to route_to("cds#update", :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/cds/1").to route_to("cds#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/cds/1").to route_to("cds#destroy", :id => "1")
    end

  end
end
