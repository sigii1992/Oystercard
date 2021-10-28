require 'journey'

describe Journey do
  let(:station) { double :station }
  let(:journey) { described_class.new(:station)}

  it 'should start with an entry station' do
    expect(journey.entry_station).to eq :station
  end

  it 'should know that the journey is not completed' do
    expect(journey).not_to be_complete
  end

  describe '#exit' do
    it 'should end with exit station saved' do
      journey.exit(station)
      expect(journey.exit_station).to eq station
    end

    it 'should know that journey is completed' do
      journey.exit(station)
      expect(journey).to be_complete
    end
  end

  describe '#fare' do
    it 'has a penalty fair' do
      expect(journey.fare).to eq Journey::PENALTY_FARE
    end
  end
end