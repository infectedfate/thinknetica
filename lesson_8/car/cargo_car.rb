class CargoCar < Car

  validate :capacity, :presence
  def initialize(capacity)
    super('cargo', capacity)
  end
end
