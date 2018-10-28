class CargoCar < Car
  include Validation

  validate :capacity, :presence
  def initialize(capacity)
    super('cargo', capacity)
  end
end
