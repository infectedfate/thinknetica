class PassengerCar < Car

  validate :capacity, :presence

  def initialize(capacity)
    super('passenger', capacity)
  end
end
