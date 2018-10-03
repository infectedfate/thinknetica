require_relative 'vendor'

class Car
  include Vendor

  attr_reader :type

  TYPE_FORMAT = /^[a-z0-9]{3}\-?[a-z0-9]{2}$/i

  def initialize(type)
    @type = type
    validate!
  end

  def cargo?
    @type == 'cargo'
  end

  def passenger?
    @type == 'passenger'
  end

  def validate!
    raise 'Указан тип невалидного формата' if @type !~ TYPE_FORMAT
  end

  protected

  def valid?
    validate!
    true
  rescue
    false
  end
end
