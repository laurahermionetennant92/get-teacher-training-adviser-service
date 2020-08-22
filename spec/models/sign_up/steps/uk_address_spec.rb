require "rails_helper"

RSpec.describe SignUp::Steps::UkAddress do
  include_context "wizard step"
  it_behaves_like "a wizard step"

  context "attributes" do
    it { is_expected.to respond_to :address_line1 }
    it { is_expected.to respond_to :address_line2 }
    it { is_expected.to respond_to :address_city }
    it { is_expected.to respond_to :address_postcode }
  end

  describe "#address_line1" do
    it { is_expected.to_not allow_values("", nil).for :address_line1 }
    it { is_expected.to allow_values("7", "7 Main Street").for :address_line1 }
  end

  describe "#address_city" do
    it { is_expected.to_not allow_values("", nil).for :address_city }
    it { is_expected.to allow_value("Manchester").for :address_city }
  end

  describe "#address_postcode" do
    it { is_expected.to_not allow_values("", nil).for :address_postcode }
    it { is_expected.to allow_values("eh3 9eh", "TR1 1XY", "hs13eq").for :address_postcode }
  end

  describe "#skipped?" do
    it "returns false if uk_or_overseas is UK" do
      wizardstore["uk_or_overseas"] = SignUp::Steps::UkOrOverseas::OPTIONS[:uk]
      expect(subject).to_not be_skipped
    end

    it "returns true if returning_to_teaching is Overseas" do
      wizardstore["uk_or_overseas"] = SignUp::Steps::UkOrOverseas::OPTIONS[:overseas]
      expect(subject).to be_skipped
    end
  end
end