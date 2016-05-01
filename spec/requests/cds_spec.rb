require 'rails_helper'

RSpec.describe "Cds", type: :request do
  describe "GET /cds" do
    it "works! (now write some real specs)" do
      get cds_path
      expect(response).to have_http_status(200)
    end
  end
end
