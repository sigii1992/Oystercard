class Oystercard
  attr_reader :balance, :in_journey, :journeys
  CARD_LIMIT = 90
  MINIMUM_BALANCE = 1
  FARE = 1

  def initialize
    @balance = 0
    @journeys = {}
  end

  def top_up(amount)
    fail "The limit is #{CARD_LIMIT}, can not add more money on your oystercard!" if exceeds_limit?(amount)
    @balance += amount 
  end
  
  def touch_in(station)
    fail "Insufficient amount" if balance < MINIMUM_BALANCE
    @journeys["entry_station"] = station
    
  end

  def touch_out(station)
    deduct(FARE)
    @journeys["exit_station"] = station
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