class CargoTrain < Train
  def initialize(number)
    super(number, 'cargo')
  end

  def attache_the_car(car)
    super(car) if car.cargo?
  end
end
