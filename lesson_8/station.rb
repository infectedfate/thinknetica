require_relative 'instance_counter'
require_relative 'accessors'
require_relative 'validation'


class Station
  NAME_FORMAT = /^[а-яa-z0-9]{2,}$/i

  include InstanceCounter
  include Validation
  extend Accessors


  attr_reader :trains, :name

  validate :name, :presence
  validate :name, :format, NAME_FORMAT

  @@stations = []

  def self.all
    @@stations
  end

  def initialize(name)
    @name = name
    @trains = []
    @@stations << self
    validate!
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
end
