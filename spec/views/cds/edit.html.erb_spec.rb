require 'rails_helper'

RSpec.describe "cds/edit", type: :view do
  before(:each) do
    @cd = assign(:cd, Cd.create!(
      :name => "MyString",
      :code => 1,
      :time_in_sec => 1
    ))
  end

  it "renders the edit cd form" do
    render

    assert_select "form[action=?][method=?]", cd_path(@cd), "post" do

      assert_select "input#cd_name[name=?]", "cd[name]"

      assert_select "input#cd_code[name=?]", "cd[code]"

      assert_select "input#cd_time_in_sec[name=?]", "cd[time_in_sec]"
    end
  end
end
