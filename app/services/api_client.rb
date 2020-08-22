require "get_into_teaching_api_client"

class ApiClient
  class << self
    def get_teaching_subjects
      api_instance = GetIntoTeachingApiClient::TypesApi.new
      api_instance.get_teaching_subjects
    end

    def get_candidate_initial_teacher_training_years
      api_instance = GetIntoTeachingApiClient::TypesApi.new
      api_instance.get_candidate_initial_teacher_training_years
    end

    def get_candidate_preferred_education_phases
      api_instance = GetIntoTeachingApiClient::TypesApi.new
      api_instance.get_candidate_preferred_education_phases
    end

    def get_qualification_degree_status
      api_instance = GetIntoTeachingApiClient::TypesApi.new
      api_instance.get_qualification_degree_status
    end

    def get_qualification_uk_degree_grades
      api_instance = GetIntoTeachingApiClient::TypesApi.new
      api_instance.get_qualification_uk_degree_grades
    end

    def get_country_types
      api_instance = GetIntoTeachingApiClient::TypesApi.new
      api_instance.get_country_types
    end

    def get_candidate_retake_gcse_status
      api_instance = GetIntoTeachingApiClient::TypesApi.new
      api_instance.get_candidate_retake_gcse_status
    end

    def get_callback_booking_quotas
      api_instance = GetIntoTeachingApiClient::CallbackBookingQuotasApi.new
      api_instance.get_callback_booking_quotas
    end

    def sign_up_teacher_training_adviser_candidate(body)
      api_instance = GetIntoTeachingApiClient::TeacherTrainingAdviserApi.new
      api_instance.sign_up_teacher_training_adviser_candidate(body)
    end

    def get_latest_privacy_policy
      api_instance = GetIntoTeachingApiClient::PrivacyPoliciesApi.new
      api_instance.get_latest_privacy_policy
    end

    def get_privacy_policy(policy_id)
      api_instance = GetIntoTeachingApiClient::PrivacyPoliciesApi.new
      api_instance.get_privacy_policy(policy_id)
    end
  end
end