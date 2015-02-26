require "rails_helper"

RSpec.describe CaseFilesController, type: :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/case_files").to route_to(controller: 'case_files', action: 'index', format: :json)
    end

    it "routes to #new" do
      expect(:get => "/case_files/new").to route_to(controller: 'case_files', action: 'new', format: :json)
    end

    it "routes to #show" do
      expect(:get => "/case_files/1").to route_to(controller: 'case_files', action: 'show', format: :json, :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/case_files/1/edit").to route_to(controller: 'case_files', action: 'edit', format: :json, :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/case_files").to route_to(controller: 'case_files', action: 'create', format: :json)
    end

    it "routes to #update" do
      expect(:put => "/case_files/1").to route_to(controller: 'case_files', action: 'update', format: :json, :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/case_files/1").to route_to(controller: 'case_files', action: 'destroy', format: :json, :id => "1")
    end

  end
end
