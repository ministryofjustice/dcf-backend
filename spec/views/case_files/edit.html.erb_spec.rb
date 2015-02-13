require 'rails_helper'

RSpec.describe "case_files/edit", type: :view do
  before(:each) do
    @case_file = assign(:case_file, CaseFile.create!(
      :urn => "MyString",
      :blob => "MyText"
    ))
  end

  it "renders the edit case_file form" do
    render

    assert_select "form[action=?][method=?]", case_file_path(@case_file), "post" do

      assert_select "input#case_file_urn[name=?]", "case_file[urn]"

      assert_select "textarea#case_file_blob[name=?]", "case_file[blob]"
    end
  end
end
