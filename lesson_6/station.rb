require_relative 'instance_counter'

class Station
  NAME_FORMAT = /^[a-z0-9]{2}$/i
  include InstanceCounter

  attr_reader :trains, :name

  @@stations = []

  def self.all
    @@stations
  end

  def initialize(name)
    @name = name
    validate!
    @trains = []
    @@stations << self
    register_instance
  end

  def take_the_train(train)
    @trains << train
  end

  def send_a_train(train)
    @trains.delete(train)
  end

  def sort_by_type(type)
    @trains.select { |train| train.type == type }
  end

  def validate!
    raise ArgumentError, 'Аргумент должен быть строкой' if @name !~ NAME_FORMAT
  end

  protected

  def valid?
    validate!
    true
  rescue
    false
  end
end
