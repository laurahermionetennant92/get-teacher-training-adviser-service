require "rails_helper"

RSpec.describe CookiePreferencesController do
  subject { response }

  describe "#show" do
    before { get cookie_preference_path }

    it { is_expected.to have_http_status :success }
    it { expect(subject.body).to match "Cookie settings" }
  end
end
