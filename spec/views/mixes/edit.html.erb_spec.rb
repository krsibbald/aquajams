require 'rails_helper'

RSpec.describe "mixes/edit", type: :view do
  before(:each) do
    @mix = assign(:mix, Mix.create!(
      :name => "MyString",
      :length_in_sec => 1,
      :description => "MyText",
      :source => "MyText",
      :music_type => "MyText",
      :notes => "MyText"
    ))
  end

  it "renders the edit mix form" do
    render

    assert_select "form[action=?][method=?]", mix_path(@mix), "post" do

      assert_select "input#mix_name[name=?]", "mix[name]"

      assert_select "input#mix_length_in_sec[name=?]", "mix[length_in_sec]"

      assert_select "textarea#mix_description[name=?]", "mix[description]"

      assert_select "textarea#mix_source[name=?]", "mix[source]"

      assert_select "textarea#mix_music_type[name=?]", "mix[music_type]"

      assert_select "textarea#mix_notes[name=?]", "mix[notes]"
    end
  end
end
