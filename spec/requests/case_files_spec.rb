require 'rails_helper'

RSpec.describe "CaseFiles", type: :request do
  describe "GET /case_files" do
    it "works! (now write some real specs)" do
      get case_files_path
      expect(response).to have_http_status(200)
    end
  end
end
