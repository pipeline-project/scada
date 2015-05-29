require "rails_helper"

RSpec.describe StepsController, type: :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/steps").to route_to("steps#index")
    end

    it "routes to #new" do
      expect(:get => "/steps/new").to route_to("steps#new")
    end

    it "routes to #show" do
      expect(:get => "/steps/1").to route_to("steps#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/steps/1/edit").to route_to("steps#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/steps").to route_to("steps#create")
    end

    it "routes to #update" do
      expect(:put => "/steps/1").to route_to("steps#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/steps/1").to route_to("steps#destroy", :id => "1")
    end

  end
end
