class PassengerTrain < Train
  include Validation
  extend Accessors

  attr_accessor_with_history :route

  validate :number, :presence
  validate :number, :format, NUMBER_FORMAT

  def initialize(number)
    super(number, 'passenger')
  end

  def attach_the_car(car)
    super(car) if car.passenger?
  end
end
