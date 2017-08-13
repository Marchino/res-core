require 'spec_helper'

describe "ToneAnalyzer" do
  let(:tone_analyzer){ ResCore::ToneAnalyzer.new }
  it "loads positive words" do
    expect(tone_analyzer.positive_words.count).to be > 0
  end

  it "loads negative words" do
    expect(tone_analyzer.negative_words.count).to be > 0
  end

  it "calculates a numeric score for a text" do
    expect(tone_analyzer.calculate_score 'sample text').to be_a Integer
  end
  
  context "for a positive text" do
    it "gives 100 to a text containing just by positive words" do
      expect(tone_analyzer.calculate_score "this is a great product and I liked very much").to eq(100)
    end

    it "gives 67 to a text containing 2 positive and 1 negative words" do
      expect(tone_analyzer.calculate_score "this is a great phone with an awesome screen but battery life is bad").to eq(67)
    end

    it "gives 75 to a text containing 3 positive and 1 negative words" do
      expect(tone_analyzer.calculate_score "this is a great and desirable phone with an awesome screen but battery life is bad").to eq(75)
    end
  end

  context "for a neutral text" do
    it "gives 50 to a text containing just unknown words" do
      expect(tone_analyzer.calculate_score "this is a product").to eq(50)
    end

    it "gives 50 to a text containing an equal number of positive and negative words" do
      expect(tone_analyzer.calculate_score "this phone has a great screen but bad battery life").to eq(50)
    end
  end

  context "for a negative review" do
    it "gives 0 to a text containing just negative words" do
      expect(tone_analyzer.calculate_score "this is bad product that I hated very much").to eq(0)
    end

    it "gives a 20 to a text containing 2 positive words and 8 negative" do
      expect(tone_analyzer.calculate_score "this is the worst phone I had. Although screen resolution was amazing, colors were garbage. design was questionable and materials felt cheap.").to eq(20)
    end
  end
end
