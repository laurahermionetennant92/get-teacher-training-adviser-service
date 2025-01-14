module TeacherTrainingAdviser::Steps
  class AcceptPrivacyPolicy < DFEWizard::Step
    attribute :accepted_policy_id, :string

    validates :accepted_policy_id, policy: true

    def reviewable_answers
      {}
    end
  end
end
