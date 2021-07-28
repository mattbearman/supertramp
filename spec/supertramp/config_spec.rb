# frozen_string_literal: true

RSpec.describe Supertramp::Config do
  describe 'uppercase' do
    context 'with the default value' do
      subject { described_class.new.uppercase }

      it { is_expected.to be_truthy }
    end
  end

  describe 'colours default' do
    subject { described_class.new.colours }

    it { is_expected.to match_array(%w[#B91C1C #B45309 #047857 #1D4ED8 #6D28D9]) }
  end
end
