require 'rails_helper'

RSpec.describe "cds/index", type: :view do
  before(:each) do
    assign(:cds, [
      Cd.create!(
        :name => "Name",
        :code => 1,
        :time_in_sec => 2
      ),
      Cd.create!(
        :name => "Name",
        :code => 1,
        :time_in_sec => 2
      )
    ])
  end

  it "renders a list of cds" do
    render
    assert_select "tr>td", :text => "Name".to_s, :count => 2
    assert_select "tr>td", :text => 1.to_s, :count => 2
    assert_select "tr>td", :text => 2.to_s, :count => 2
  end
end
