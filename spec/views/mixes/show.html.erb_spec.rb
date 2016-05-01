require 'rails_helper'

RSpec.describe "mixes/show", type: :view do
  before(:each) do
    @mix = assign(:mix, Mix.create!(
      :name => "Name",
      :length_in_sec => 1,
      :description => "MyText",
      :source => "MyText",
      :music_type => "MyText",
      :notes => "MyText"
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Name/)
    expect(rendered).to match(/1/)
    expect(rendered).to match(/MyText/)
    expect(rendered).to match(/MyText/)
    expect(rendered).to match(/MyText/)
    expect(rendered).to match(/MyText/)
  end
end
