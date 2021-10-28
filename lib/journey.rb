class Journey
  attr_reader :entry_station, :exit_station
  PENALTY_FARE = 6

  def initialize(entry_station = nil)
    @entry_station = entry_station
    @exit_station = nil
    @complete = false
  end
  
  def exit(station)
    @exit_station = station
    @complete = true
  end

  def fare
    PENALTY_FARE
  end

  def complete?
    !!@complete
  end
end