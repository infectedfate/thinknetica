class PassengerTrain < Train
  def initialize(number)
    super(number, 'passenger')
  end

  def attach_the_car(car)
    super(car) if car.passenger?
  end
end
