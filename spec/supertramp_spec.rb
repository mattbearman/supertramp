# frozen_string_literal: true

RSpec.describe Supertramp do
  before do
    allow(Supertramp::Avatar).to receive(:new).and_call_original
  end

  describe '#to_s' do
    it 'creates an instance of Avatar and calls its to_s method' do
      expect(described_class.new(initials: 'st').to_s)
        .to eq(Supertramp::Avatar.new(initials: 'ST', background: '#1D4ED8').to_s)
    end
  end

  describe 'extracting initials from the name argument' do
    it 'uses the first letter from each word' do
      described_class.new(name: 'roger hodgson').to_s

      expect(Supertramp::Avatar).to have_received(:new).with(hash_including(initials: 'RH'))
    end
  end

  describe 'transforming initals to uppercase' do
    before do
      described_class.configure do |config|
        config.uppercase = uppercase
      end

      described_class.new(initials: 'rh').to_s
    end

    context 'when config.uppercase is true' do
      let(:uppercase) { true }

      it 'transforms the initials to upper case' do
        expect(Supertramp::Avatar).to have_received(:new).with(hash_including(initials: 'RH'))
      end
    end

    context 'when config.uppercase is false' do
      let(:uppercase) { false }

      it 'does not transform the initials' do
        expect(Supertramp::Avatar).to have_received(:new).with(hash_including(initials: 'rh'))
      end
    end
  end

  describe 'specifying a background colour' do
    it 'uses the specified colour, even if it is not in the colours array' do
      described_class.new(initials: 'st', background: 'very-very-very-dark-blue').to_s

      expect(Supertramp::Avatar).to have_received(:new).with(hash_including(background: 'very-very-very-dark-blue'))
    end
  end

  describe 'seeded random background colour choice' do
    before do
      described_class.configure do |config|
        config.colours = %w[red green yellow blue purple]
      end
    end

    it 'chooses the first colour based on the initials' do
      2.times { described_class.new(initials: 'yz').to_s }

      expect(Supertramp::Avatar).to have_received(:new).with(hash_including(background: 'green')).twice
    end

    it 'chooses the second colour based on the initials' do
      2.times { described_class.new(initials: 'ab').to_s }

      expect(Supertramp::Avatar).to have_received(:new).with(hash_including(background: 'purple')).twice
    end

    it 'chooses the same colour regarless of casing' do
      described_class.configure { |config| config.uppercase = false }

      described_class.new(initials: 'ab').to_s
      described_class.new(initials: 'AB').to_s

      expect(Supertramp::Avatar).to have_received(:new).with(hash_including(background: 'purple')).twice
    end
  end

  describe 'errors' do
    context 'without initials or names' do
      it 'raises error' do
        expect { described_class.new }.to raise_error(ArgumentError, 'either `initials:` or `name:` must be specified')
      end
    end
  end
end