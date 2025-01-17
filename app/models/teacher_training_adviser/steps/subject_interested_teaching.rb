module TeacherTrainingAdviser::Steps
  class SubjectInterestedTeaching < DFEWizard::Step
    extend ApiOptions

    attribute :preferred_teaching_subject_id, :string

    validates :preferred_teaching_subject_id, lookup_items: { method: :get_teaching_subjects }

    OMIT_SUBJECT_IDS = [
      "bc2655a1-2afa-e811-a981-000d3a276620", # Other
      "bc68e0c1-7212-e911-a974-000d3a206976", # No Preference
    ].freeze

    def self.options
      generate_api_options(GetIntoTeachingApiClient::LookupItemsApi, :get_teaching_subjects, OMIT_SUBJECT_IDS)
    end

    def reviewable_answers
      super.tap do |answers|
        answers["preferred_teaching_subject_id"] = self.class.options.key(preferred_teaching_subject_id)
      end
    end

    def skipped?
      stage_interested_teaching_step = other_step(:stage_interested_teaching)
      stage_interested_teaching_skipped = stage_interested_teaching_step.skipped?
      preferred_education_phase_id = stage_interested_teaching_step.preferred_education_phase_id
      phase_is_not_secondary = preferred_education_phase_id != StageInterestedTeaching::OPTIONS[:secondary]

      stage_interested_teaching_skipped || phase_is_not_secondary
    end
  end
end
