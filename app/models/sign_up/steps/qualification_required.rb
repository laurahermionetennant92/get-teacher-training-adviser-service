module SignUp::Steps
  class QualificationRequired < Wizard::Step
    def can_proceed?
      false
    end

    def skipped?
      @store["planning_to_retake_gcse_maths_and_english_id"] != Crm::OPTIONS[:no] &&
        @store["planning_to_retake_gcse_science_id"] != Crm::OPTIONS[:no]
    end
  end
end