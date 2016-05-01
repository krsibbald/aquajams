require 'rails_helper'

RSpec.describe "cds/show", type: :view do
  before(:each) do
    @cd = assign(:cd, Cd.create!(
      :name => "Name",
      :code => 1,
      :time_in_sec => 2
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Name/)
    expect(rendered).to match(/1/)
    expect(rendered).to match(/2/)
  end
end
