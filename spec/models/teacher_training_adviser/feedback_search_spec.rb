require "rails_helper"

RSpec.describe TeacherTrainingAdviser::FeedbackSearch do
  let(:instance) { described_class.new }

  context "attributes" do
    it { is_expected.to respond_to :created_on_or_after }
    it { is_expected.to respond_to :created_on_or_before }
  end

  context "validation" do
    it { is_expected.to validate_presence_of(:created_on_or_before) }
    it { is_expected.to validate_presence_of(:created_on_or_after) }
    it { is_expected.to allow_value(Time.zone.now.utc, 1.day.ago).for :created_on_or_before }
    it { is_expected.to_not allow_value(1.day.from_now).for :created_on_or_before }

    context "when created_on_or_before is 5/2/2020" do
      before { subject.created_on_or_before = Date.new(2020, 2, 5) }

      it { is_expected.to allow_value(subject.created_on_or_before).for :created_on_or_after }
      it { is_expected.to_not allow_value(Date.new(2020, 2, 6)).for :created_on_or_after }
    end
  end

  describe "#created_on_or_after" do
    subject { instance.created_on_or_after }

    it { is_expected.to eq(Time.zone.now.beginning_of_month.utc.to_date) }
  end

  describe "#created_on_or_before" do
    subject { instance.created_on_or_before }

    it { is_expected.to eq(Time.zone.now.utc.to_date) }
  end

  describe "#range" do
    let(:instance) do
      described_class.new(
        created_on_or_after: DateTime.new(2021, 2, 22),
        created_on_or_before: DateTime.new(2021, 3, 11),
      )
    end

    subject { instance.range }

    it do
      is_expected.to eq([
        instance.created_on_or_after,
        instance.created_on_or_before,
      ])
    end
  end

  describe "#results" do
    let(:instance) do
      described_class.new(
        created_on_or_after: DateTime.new(2020, 10, 1),
        created_on_or_before: DateTime.new(2020, 10, 5),
      )
    end

    before do
      on_or_after = instance.created_on_or_after
      on_or_before = instance.created_on_or_before

      ((on_or_after - 2.days)..(on_or_before + 2.days)).each do |date|
        create(:feedback).tap do |feedback|
          feedback.update(created_at: date)
        end
      end
    end

    subject { instance.results }

    it "returns feedback in the date range and orders by latest first" do
      dates = subject.map(&:created_at)

      expect(subject.count).to eq(5)
      expect(dates).to eq(dates.sort.reverse)
    end

    context "when invalid" do
      before { expect(instance).to receive(:invalid?) { true } }

      it { is_expected.to eq([]) }
    end
  end
end
