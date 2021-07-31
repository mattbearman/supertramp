# frozen_string_literal: true

RSpec.describe Supertramp::Avatar do
  describe '#to_s' do
    context 'when shape is square' do
      subject { described_class.new(initials: 'MB', background: 'very-very-very-dark-blue', shape: 'square').to_s }

      it { is_expected.to include('<rect') }
      it { is_expected.not_to match(/<rect.+rx="\d+".+ry="\d+"/) }
      it { is_expected.to include('fill="very-very-very-dark-blue"') }
      it { is_expected.to match(%r{<text.+?MB.+?</text>}m) }
      it { is_expected.to include('font-size="26"') }
    end

    context 'when shape is circle' do
      subject { described_class.new(initials: 'a', background: '#00ffaa', shape: 'circle').to_s }

      it { is_expected.to include('<circle') }
      it { is_expected.to include('fill="#00ffaa"') }
      it { is_expected.to match(%r{<text.+?a.+?</text>}m) }
      it { is_expected.to include('font-size="26"') }
    end

    context 'when shape is rounded rectangle' do
      subject { described_class.new(initials: 'xYz', background: 'rgb(255,127,63)', shape: 'rounded').to_s }

      it { is_expected.to match(/<rect.+rx="\d+".+ry="\d+"/) }
      it { is_expected.to include('fill="rgb(255,127,63)"') }
      it { is_expected.to match(%r{<text.+?xYz.+?</text>}m) }
      it { is_expected.to include('font-size="17"') }
    end
  end

  describe '#text_size' do
    subject { described_class.new(initials: initals, background: 'red', shape: 'rounded').text_size }

    context 'with one initial' do
      let(:initals) { 'A' }

      it { is_expected.to eq(26) }
    end

    context 'with two initials' do
      let(:initals) { 'AB' }

      it { is_expected.to eq(26) }
    end

    context 'with three initials' do
      let(:initals) { 'ABC' }

      it { is_expected.to eq(17) }
    end

    context 'with four initials (dont do this)' do
      let(:initals) { 'ABCD' }

      it { is_expected.to eq(13) }
    end

    context 'with five initials (really dont do this)' do
      let(:initals) { 'ABCDE' }

      it { is_expected.to eq(11) }
    end
  end

  describe '#shape' do
    let(:avatar) { described_class.new(initials: 'a', background: 'red', shape: 'star') }

    before { allow(avatar).to receive(:bind_template) }

    it 'adds an underscore to the argument' do
      avatar.shape

      expect(avatar).to have_received(:bind_template).with('_star')
    end
  end
end
