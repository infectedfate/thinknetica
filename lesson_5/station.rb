require_relative 'instance_counter'

class Station
  include InstanceCounter

  attr_reader :trains, :name

  @@instances = 0

  def self.all
    @@instances
  end

  def initialize(name)
    @@instances += 1
    @name = name
    @trains = []
    @@instances << self
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
end
