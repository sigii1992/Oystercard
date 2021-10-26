require 'oystercard'

describe Oystercard do
  let(:card) { Oystercard.new }

  it 'has a balance of zero' do
    expect(card.balance).to eq 0
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

  describe '#deduct' do
    it { is_expected.to respond_to(:deduct).with(1).argument }

    it 'will deduct £1 from the balance' do
      card.top_up 5
      expect { card.deduct 1}.to change { card.balance }.by -1
    end
  end

  describe '# in journey' do
    it 'is initially not in a journey' do
      expect(subject).not_to be_in_journey
    end
  end

  describe '#touch in' do
   it 'will change in journey status to true' do
    card = Oystercard.new
    expect(card.touch_in).to eq true
   end
  end

  describe '#touch out' do
    it 'will change in journey status to false' do
     card = Oystercard.new
     expect(card.touch_out).to eq false
    end
  end
end