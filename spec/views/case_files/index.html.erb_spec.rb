require 'rails_helper'

RSpec.describe "case_files/index", type: :view do
  before(:each) do
    assign(:case_files, [
      CaseFile.create!(
        :urn => "Urn",
        :blob => "MyText"
      ),
      CaseFile.create!(
        :urn => "Urn",
        :blob => "MyText"
      )
    ])
  end

  it "renders a list of case_files" do
    render
    assert_select "tr>td", :text => "Urn".to_s, :count => 2
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
  end
end
