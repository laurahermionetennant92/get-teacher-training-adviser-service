module SignUp::Steps
  class GcseScience < Wizard::Step
    attribute :has_gcse_science_id, :integer

    validates :has_gcse_science_id, types: { method: :get_candidate_retake_gcse_status, message: "You must select either yes or no" }

    OPTIONS = Crm::OPTIONS

    def skipped?
      @store["preferred_education_phase_id"] == StageInterestedTeaching::OPTIONS[:secondary] ||
        [
          HaveADegree::DEGREE_OPTIONS[:studying],
          HaveADegree::DEGREE_OPTIONS[:degree],
        ].none?(@store["degree_options"])
    end
  end
end