class Station
  attr_accessor :trains

  def initialize(name)
    @name = name
    @trains = []
  end

  def take_the_train(train)
    @trains << train
  end

  def send_a_train(train)
    @trains.delete(train)
  end

  def sort_by_type(type)
  end
end
