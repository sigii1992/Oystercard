require 'station'

describe Station do
  let(:station) { described_class.new("Piccadilli Circus", 1) }

  it 'has a name' do
    expect(station.name).to eq "Piccadilli Circus"
  end

  it 'knows in which zone the station is' do
    expect(station.zone).to eq 1
  end
end
    