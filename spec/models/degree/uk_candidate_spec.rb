require 'rails_helper'

RSpec.describe UkCandidate do
  let(:address) { build(:degree_uk_candidate) }
  let(:no_address_line_1) { build(:degree_uk_candidate, address_line_1: "") }

  describe "validation" do

    context "without required attributes" do
      it "is invalid" do
        expect(no_address_line_1).to_not be_valid
      end
    end

    context "with invalid postcodes" do
      ['giib', 'tr111 1uf', 'FFFF', 'blahblah', 'p3000 xxx'].each do |invalid_postcode|
        let(:instance) { build(:degree_uk_candidate, postcode: invalid_postcode) }
        it "is not valid" do
          expect(instance).to_not be_valid
        end
      end
    end

    context "with valid postcodes" do
      ['eh3 9eh', 'tr1 1xy', 'hs1 3eq'].each do |valid_postcode|
        let(:instance) { build(:degree_uk_candidate, postcode: valid_postcode) }
        it "is valid" do
          expect(instance).to be_valid
        end
      end
    end

  end

  describe '#next_step' do
    it "returns the next step" do
      expect(address.next_step).to eq('degree/uk_completion')
    end
  end

end