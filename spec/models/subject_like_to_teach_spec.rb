require 'rails_helper'

RSpec.describe SubjectLikeToTeach do
  let(:what_subject) { build(:subject_like_to_teach) }

  describe "validation" do
    context "with invalid subject options" do
      ['skiing', 'fishing', 'golfing', 'surfing' ].each do |invalid_subject|
        let(:instance) { build(:subject_like_to_teach, like_to_teach: invalid_subject) }
        it "is not valid" do
          expect(instance).to_not be_valid
        end
      end
    end

    context "with valid subject options" do
      ['maths', 'physics', 'modern foreign language'].each do |valid_subject|
        let(:instance) { build(:subject_like_to_teach, like_to_teach: valid_subject) }
        it "is valid" do
          expect(instance).to be_valid
        end
      end
    end
  end

  describe "#next_step" do
    it "returns the correct step" do
      expect(what_subject.next_step).to eq("date_of_birth")
    end
  end
end