require 'rails_helper'

RSpec.describe "cds/new", type: :view do
  before(:each) do
    assign(:cd, Cd.new(
      :name => "MyString",
      :code => 1,
      :time_in_sec => 1
    ))
  end

  it "renders new cd form" do
    render

    assert_select "form[action=?][method=?]", cds_path, "post" do

      assert_select "input#cd_name[name=?]", "cd[name]"

      assert_select "input#cd_code[name=?]", "cd[code]"

      assert_select "input#cd_time_in_sec[name=?]", "cd[time_in_sec]"
    end
  end
end
