# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Supertramp::Avatar do
  describe '#to_s' do
    context 'when shape is square' do
      subject { described_class.new(initials: 'MB', background: 'very-very-very-dark-blue', shape: 'square').to_s }

      it { is_expected.to include('<rect') }
      it { is_expected.not_to match(/<rect.+rx="\d+".+ry="\d+"/) }
      it { is_expected.to include('fill="very-very-very-dark-blue"') }
      it { is_expected.to match(%r{<text.+?MB.+?</text>}m) }
    end

    context 'when shape is circle' do
      subject { described_class.new(initials: 'a', background: '#00ffaa', shape: 'circle').to_s }

      it { is_expected.to include('<circle') }
      it { is_expected.to include('fill="#00ffaa"') }
      it { is_expected.to match(%r{<text.+?a.+?</text>}m) }
    end

    context 'when shape is rounded rectangle' do
      subject { described_class.new(initials: 'xYz', background: 'rgb(255,127,63)', shape: 'rounded').to_s }

      it { is_expected.to match(/<rect.+rx="\d+".+ry="\d+"/) }
      it { is_expected.to include('fill="rgb(255,127,63)"') }
      it { is_expected.to match(%r{<text.+?xYz.+?</text>}m) }
    end
  end
end
