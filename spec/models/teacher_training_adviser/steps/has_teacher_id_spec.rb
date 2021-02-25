require "rails_helper"

RSpec.describe TeacherTrainingAdviser::Steps::HasTeacherId do
  include_context "wizard step"
  it_behaves_like "a wizard step"

  context "attributes" do
    it { is_expected.to respond_to :has_id }
  end

  describe "has_id" do
    it { is_expected.to_not allow_value(nil).for :has_id }
    it { is_expected.to allow_values(true, false).for :has_id }
  end

  describe "#skipped?" do
    it "returns false if returning_to_teaching is true" do
      expect_any_instance_of(TeacherTrainingAdviser::Steps::ReturningTeacher).to receive(:returning_to_teaching) { true }
      expect(subject).to_not be_skipped
    end

    it "returns true if returning_to_teaching is false" do
      expect_any_instance_of(TeacherTrainingAdviser::Steps::ReturningTeacher).to receive(:returning_to_teaching) { false }
      expect(subject).to be_skipped
    end

    it "returns true if teacher_id is pre-filled from crm" do
      wizardstore.persist_crm({ "teacher_id" => "1234567" })
      expect(subject).to be_skipped
    end
  end

  describe "#reviewable_answers" do
    subject { instance.reviewable_answers }
    before { instance.has_id = true }
    it { is_expected.to eq({ "has_id" => "Yes" }) }
  end
end
