class Oystercard
  attr_reader :balance, :in_journey
  CARD_LIMIT = 90
  MINIMUM_BALANCE = 1
  
  def initialize
    @balance = 0
    @in_journey = false
  end

  def top_up(amount)
    fail "The limit is #{CARD_LIMIT}, can not add more money on your oystercard!" if exceeds_limit?(amount)
    @balance += amount 
  end

  def deduct(fare)
    @balance -= fare
  end

  def touch_in
    fail "Insufficient amount" if balance < MINIMUM_BALANCE
    @in_journey = true
  end

  def touch_out
    @in_journey = false
  end

  def in_journey?
    @in_journey
  end

  private

  def exceeds_limit?(amount)
    @balance + amount > CARD_LIMIT
  end
end