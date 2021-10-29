require_relative 'station'

class Oystercard
  attr_reader :balance, :journeys, :entry_station
  CARD_LIMIT = 90
  MINIMUM_BALANCE = 1
  FARE = 1

  def initialize(station = Station)
    @balance = 0
    @journeys = []
    @entry_station
    @station = station
  end

  def top_up(amount)
    fail "The limit is #{CARD_LIMIT}, can not add more money on your oystercard!" if exceeds_limit?(amount)
    @balance += amount 
  end
  
  def touch_in(name, zone)
    fail "Insufficient amount" if balance < MINIMUM_BALANCE
    @entry_station = @station.new(name, zone)
  end

  def touch_out(name, zone)
    deduct(FARE)
    @journeys << { :entry_station => @entry_station, :exit_tation => @station.new(name, zone) }
    # @journeys << { :entry_station => @entry_station, :exit_station => station }
    @entry_station = nil
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