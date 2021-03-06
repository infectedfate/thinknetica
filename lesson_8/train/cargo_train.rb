class CargoTrain < Train

  attr_accessors_with_history :route

  validate :number, :presence
  validate :number, :format, NUMBER_FORMAT

  def initialize(number)
    super(number, 'cargo')
  end

  def attache_the_car(car)
    super(car) if car.cargo?
  end
end
