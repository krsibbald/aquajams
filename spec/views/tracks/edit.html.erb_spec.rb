require 'rails_helper'

RSpec.describe "tracks/edit", type: :view do
  before(:each) do
    @track = assign(:track, Track.create!(
      :mix => nil,
      :song => nil,
      :ord => 1
    ))
  end

  it "renders the edit track form" do
    render

    assert_select "form[action=?][method=?]", track_path(@track), "post" do

      assert_select "input#track_mix_id[name=?]", "track[mix_id]"

      assert_select "input#track_song_id[name=?]", "track[song_id]"

      assert_select "input#track_ord[name=?]", "track[ord]"
    end
  end
end
