# frozen_string_literal: true

RSpec.describe Supertramp::Avatar do
  describe '#to_s' do
    subject { described_class.new(initials: 'MB', background: 'very-very-very-dark-blue').to_s }

    it { is_expected.to include('fill="very-very-very-dark-blue"') }
    it { is_expected.to match(/<text.+?MB.+?<\/text>/m) }
  end
end
