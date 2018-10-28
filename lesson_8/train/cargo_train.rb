class CargoTrain < Train
  include Validation

  validate :number, :presence
  validate :number, :format, NUMBER_FORMAT

  def initialize(number)
    super(number, 'cargo')
  end

  def attache_the_car(car)
    super(car) if car.cargo?
  end
end
