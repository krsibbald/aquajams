require 'rails_helper'

RSpec.describe "tracks/index", type: :view do
  before(:each) do
    assign(:tracks, [
      Track.create!(
        :mix => nil,
        :song => nil,
        :ord => 1
      ),
      Track.create!(
        :mix => nil,
        :song => nil,
        :ord => 1
      )
    ])
  end

  it "renders a list of tracks" do
    render
    assert_select "tr>td", :text => nil.to_s, :count => 2
    assert_select "tr>td", :text => nil.to_s, :count => 2
    assert_select "tr>td", :text => 1.to_s, :count => 2
  end
end
