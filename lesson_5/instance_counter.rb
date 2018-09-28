module InstanceCounter

  @@count = []

  def self.instances
    @@count
  end

  protected

  attr_accessor :count

  def register_instance
    @@count += ObjectSpace.each_object(self)
  end
end
