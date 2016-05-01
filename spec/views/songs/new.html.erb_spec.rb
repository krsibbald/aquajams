require 'rails_helper'

RSpec.describe "songs/new", type: :view do
  before(:each) do
    assign(:song, Song.new(
      :name => "MyString",
      :artist => nil,
      :length_in_sec => 1,
      :year => 1,
      :top_billboard_spot => 1,
      :billboard_weeks => "9.99"
    ))
  end

  it "renders new song form" do
    render

    assert_select "form[action=?][method=?]", songs_path, "post" do

      assert_select "input#song_name[name=?]", "song[name]"

      assert_select "input#song_artist_id[name=?]", "song[artist_id]"

      assert_select "input#song_length_in_sec[name=?]", "song[length_in_sec]"

      assert_select "input#song_year[name=?]", "song[year]"

      assert_select "input#song_top_billboard_spot[name=?]", "song[top_billboard_spot]"

      assert_select "input#song_billboard_weeks[name=?]", "song[billboard_weeks]"
    end
  end
end
