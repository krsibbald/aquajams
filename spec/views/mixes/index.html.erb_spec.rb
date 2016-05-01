require 'rails_helper'

RSpec.describe "mixes/index", type: :view do
  before(:each) do
    assign(:mixes, [
      Mix.create!(
        :name => "Name",
        :length_in_sec => 1,
        :description => "MyText",
        :source => "MyText",
        :music_type => "MyText",
        :notes => "MyText"
      ),
      Mix.create!(
        :name => "Name",
        :length_in_sec => 1,
        :description => "MyText",
        :source => "MyText",
        :music_type => "MyText",
        :notes => "MyText"
      )
    ])
  end

  it "renders a list of mixes" do
    render
    assert_select "tr>td", :text => "Name".to_s, :count => 2
    assert_select "tr>td", :text => 1.to_s, :count => 2
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
  end
end
