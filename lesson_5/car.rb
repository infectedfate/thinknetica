require_relative 'vendor'

class Car
  include Vendor

  attr_reader :type

  def initialize(type)
    @type = type
  end

  def cargo?
    @type == 'cargo'
  end

  def passenger?
    @type == 'passenger'
  end
end
