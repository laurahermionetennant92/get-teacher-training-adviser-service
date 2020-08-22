require "rails_helper"

RSpec.describe SignUp::Steps::WhatDegreeClass do
  include_context "wizard step"
  it_behaves_like "a wizard step"
  it_behaves_like "a wizard step that exposes API types as options", :get_qualification_uk_degree_grades

  context "attributes" do
    it { is_expected.to respond_to :uk_degree_grade_id }
  end

  describe "#uk_degree_grade_id" do
    it "allows a valid uk_degree_grade_id" do
      grade = GetIntoTeachingApiClient::TypeEntity.new(id: 123)
      allow_any_instance_of(GetIntoTeachingApiClient::TypesApi).to \
        receive(:get_qualification_uk_degree_grades) { [grade] }
      expect(subject).to allow_value(grade.id).for :uk_degree_grade_id
    end

    it { is_expected.to_not allow_values("", nil).for :uk_degree_grade_id }
  end

  describe "#skipped?" do
    it "returns false if degree_options is studying/degree" do
      wizardstore["degree_options"] = HaveADegree::DEGREE_OPTIONS[:studying]
      expect(subject).to_not be_skipped
      wizardstore["degree_options"] = HaveADegree::DEGREE_OPTIONS[:degree]
      expect(subject).to_not be_skipped
    end

    it "returns true if degree_options is not studying/degree" do
      wizardstore["degree_options"] = HaveADegree::DEGREE_OPTIONS[:equivalent]
      expect(subject).to be_skipped
    end
  end

  describe "#studying?" do
    it "returns true if degree_options is studying" do
      wizardstore["degree_options"] = HaveADegree::DEGREE_OPTIONS[:studying]
      expect(subject).to be_studying
    end

    it "returns false if degree_options is not studying" do
      wizardstore["degree_options"] = HaveADegree::DEGREE_OPTIONS[:degree]
      expect(subject).to_not be_studying
    end
  end
end