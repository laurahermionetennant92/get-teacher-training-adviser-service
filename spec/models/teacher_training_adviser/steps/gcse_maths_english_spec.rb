require "rails_helper"

RSpec.describe TeacherTrainingAdviser::Steps::GcseMathsEnglish do
  include_context "wizard step"
  it_behaves_like "a wizard step"

  context "attributes" do
    it { is_expected.to respond_to :has_gcse_maths_and_english_id }
  end

  describe "has_gcse_maths_and_english_id" do
    it { is_expected.to_not allow_values(nil, 123).for :has_gcse_maths_and_english_id }
    it { is_expected.to allow_values(*TeacherTrainingAdviser::Steps::GcseMathsEnglish::OPTIONS.values).for :has_gcse_maths_and_english_id }
  end

  describe "#skipped?" do
    it "returns false if degree_options is studying/degree" do
      wizardstore["degree_options"] = TeacherTrainingAdviser::Steps::HaveADegree::DEGREE_OPTIONS[:studying]
      expect(subject).to_not be_skipped
      wizardstore["degree_options"] = TeacherTrainingAdviser::Steps::HaveADegree::DEGREE_OPTIONS[:degree]
      expect(subject).to_not be_skipped
    end

    it "returns true if degree_options is not studying/degree" do
      wizardstore["degree_options"] = TeacherTrainingAdviser::Steps::HaveADegree::DEGREE_OPTIONS[:equivalent]
      expect(subject).to be_skipped
    end
  end
end
