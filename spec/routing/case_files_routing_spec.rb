require "rails_helper"

RSpec.describe CaseFilesController, type: :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/case_files").to route_to("case_files#index")
    end

    it "routes to #new" do
      expect(:get => "/case_files/new").to route_to("case_files#new")
    end

    it "routes to #show" do
      expect(:get => "/case_files/1").to route_to("case_files#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/case_files/1/edit").to route_to("case_files#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/case_files").to route_to("case_files#create")
    end

    it "routes to #update" do
      expect(:put => "/case_files/1").to route_to("case_files#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/case_files/1").to route_to("case_files#destroy", :id => "1")
    end

  end
end
