require 'rails_helper'

RSpec.describe Mix, type: :model do
  describe "import" do
    let(:csv){"#{Rails.root}/spec/support/nine_mixes.csv"}
    
    it "should import" do
      expect(Mix.count).to eq 0
      Mix.import(csv)
      expect(Mix.count).to eq 9
    end
    it "imports correctly" do
      Mix.import(csv)
      expect(Mix.where(code: 40).count).to eq 1
      mix40 = Mix.where(code: '40').first
      expect(mix40.multiple).to eq false
    #   expect(mix40.length_in_sec).to eq (70 * 60)
    #   expect(mix40.date_for_mix_list).to eq Date.new(2007, 9, 9)
    #   expect(mix40.recorded_at).to eq Date.new(2010, 4, 27)
    #   expect(mix.description).to eq "Temptations (308), 50%;  Golden Age Novelty Songs (83), 25%; Big Band (314), 25%."
    end
  end
end
