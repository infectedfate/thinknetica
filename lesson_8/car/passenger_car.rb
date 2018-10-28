class PassengerCar < Car
  include Validation

  validate :capacity, :presence
  def initialize(capacity)
    super('passenger', capacity)
  end
end
