require 'rails_helper'

RSpec.describe "songs/index", type: :view do
  before(:each) do
    assign(:songs, [
      Song.create!(
        :name => "Name",
        :artist => nil,
        :length_in_sec => 1,
        :year => 2,
        :top_billboard_spot => 3,
        :billboard_weeks => "9.99"
      ),
      Song.create!(
        :name => "Name",
        :artist => nil,
        :length_in_sec => 1,
        :year => 2,
        :top_billboard_spot => 3,
        :billboard_weeks => "9.99"
      )
    ])
  end

  it "renders a list of songs" do
    render
    assert_select "tr>td", :text => "Name".to_s, :count => 2
    assert_select "tr>td", :text => nil.to_s, :count => 2
    assert_select "tr>td", :text => 1.to_s, :count => 2
    assert_select "tr>td", :text => 2.to_s, :count => 2
    assert_select "tr>td", :text => 3.to_s, :count => 2
    assert_select "tr>td", :text => "9.99".to_s, :count => 2
  end
end
