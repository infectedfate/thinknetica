require_relative 'vendor'

class Car
  include Vendor

  attr_reader :type

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

  def valid?
    validate!
    true
  rescue
    false
  end

  protected

  def validate!
    raise 'Указан тип невалидного формата' unless type.eql?('cargo') || type.eql?('passenger')
  end
end
