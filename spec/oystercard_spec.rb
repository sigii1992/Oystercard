require 'oystercard'

describe Oystercard do
  let(:card) { Oystercard.new }
  let(:station) { double("station", :name => "Piccadilli", :zone => 1) }
  let(:journey) { {entry_station: station, exit_station: station} }

  it 'has a balance of zero' do
    expect(card.balance).to eq 0
  end

  it 'expects journeys list to be empty' do
    expect(card.journeys).to be_empty
  end

  describe '#top_up' do
    it { is_expected.to respond_to(:top_up).with(1).argument }

    it 'will top up the balance by 5' do
      expect { card.top_up 5 }.to change { card.balance }.by 5
    end

    it 'throws an exception if new balance exceeds the limit' do
      card.top_up(Oystercard::CARD_LIMIT)
      expect { card.top_up 1 }.to raise_error "The limit is #{Oystercard::CARD_LIMIT}, can not add more money on your oystercard!"
    end
  end

  describe '#in_journey' do
    it 'is initially not in a journey' do
      expect(subject).not_to be_in_journey
    end
  end

  describe '#touch in' do
   it 'will raise an error if insufficient amount' do
    expect { card.touch_in(station, station) }.to raise_error "Insufficient amount"
   end

   it 'saves entry station' do
    card.top_up 5
    a = card.touch_in(station, station)
    expect(card.entry_station).to eq a
   end
  end

  describe '#touch out' do
     it 'deduct fare from balance' do
      card.top_up 5
      card.touch_in(station, station)
      expect { card.touch_out(station, station) }.to change { card.balance }.by(-Oystercard::FARE)
    end
  
    it 'changes recorded entry station to nil' do
      card.top_up 5
      card.touch_in(station, station)
      card.touch_out(station, station)
      expect(card.entry_station).to eq nil
    end

    it "creates one journey after touching in and out" do
      card.top_up 5
      card.touch_in(station, station)
      card.touch_out(station, station)
      expect(card.journeys).to include {journey}
    end
  end
end