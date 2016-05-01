require 'rails_helper'

RSpec.describe "tracks/new", type: :view do
  before(:each) do
    assign(:track, Track.new(
      :mix => nil,
      :song => nil,
      :ord => 1
    ))
  end

  it "renders new track form" do
    render

    assert_select "form[action=?][method=?]", tracks_path, "post" do

      assert_select "input#track_mix_id[name=?]", "track[mix_id]"

      assert_select "input#track_song_id[name=?]", "track[song_id]"

      assert_select "input#track_ord[name=?]", "track[ord]"
    end
  end
end
