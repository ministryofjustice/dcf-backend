require 'rails_helper'

RSpec.describe "case_files/new", type: :view do
  before(:each) do
    assign(:case_file, CaseFile.new(
      :urn => "MyString",
      :blob => "MyText"
    ))
  end

  it "renders new case_file form" do
    render

    assert_select "form[action=?][method=?]", case_files_path, "post" do

      assert_select "input#case_file_urn[name=?]", "case_file[urn]"

      assert_select "textarea#case_file_blob[name=?]", "case_file[blob]"
    end
  end
end
