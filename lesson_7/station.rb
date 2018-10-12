require_relative 'instance_counter'
require_relative 'valid'

class Station
  NAME_FORMAT = /^[а-яa-z0-9]{2,}$/i

  include InstanceCounter
  include Validate

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

  def each_train(block)
    @trains.each { |train| block.call train }
  end

  protected

  def validate!
    raise ArgumentError, 'Название должно состоять не менее чем из двух символов' if @name !~ NAME_FORMAT
  end
end
