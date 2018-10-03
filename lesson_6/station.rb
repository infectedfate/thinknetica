require_relative 'instance_counter'

class Station
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
    raise ArgumentError, 'Аргумент должен быть строкой' unless @name.is_a? String

    true
  end

  def valid?
    validate!
  rescue
    false
  end
end
