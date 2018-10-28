class CargoCar < Car
  include Validation

  validate :capacity, :capacity
  def initialize(capacity)
    super('cargo', capacity)
  end
end
