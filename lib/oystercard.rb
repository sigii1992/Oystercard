class Oystercard
  attr_reader :balance, :in_journey, :entry_station
  CARD_LIMIT = 90
  MINIMUM_BALANCE = 1
  FARE = 1

  def initialize
    @balance = 0
    # @in_journey = false
    @entry_station 
  end

  def top_up(amount)
    fail "The limit is #{CARD_LIMIT}, can not add more money on your oystercard!" if exceeds_limit?(amount)
    @balance += amount 
  end
  
  def touch_in(station)
    fail "Insufficient amount" if balance < MINIMUM_BALANCE
    @entry_station = station
    # @in_journey = true
  end

  def touch_out
    deduct(FARE)
    @entry_station = nil
    # @in_journey = false
  end

  def in_journey?
    !!@entry_station
  end

  private

  def exceeds_limit?(amount)
    @balance + amount > CARD_LIMIT
  end

  def deduct(fare)
    @balance -= FARE
  end

end