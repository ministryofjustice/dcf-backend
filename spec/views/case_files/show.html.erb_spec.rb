require 'rails_helper'

RSpec.describe "case_files/show", type: :view do
  before(:each) do
    @case_file = assign(:case_file, CaseFile.create!(
      :urn => "Urn",
      :blob => "MyText"
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Urn/)
    expect(rendered).to match(/MyText/)
  end
end
