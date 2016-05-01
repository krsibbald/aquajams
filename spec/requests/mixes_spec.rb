require 'rails_helper'

RSpec.describe "Mixes", type: :request do
  describe "GET /mixes" do
    it "works! (now write some real specs)" do
      get mixes_path
      expect(response).to have_http_status(200)
    end
  end
end
