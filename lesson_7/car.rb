require_relative 'vendor'
require_relative 'valid'

class Car
  include Vendor
  include Validate

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

  protected

  def validate!
    raise 'Указан тип невалидного формата' unless type.eql?('cargo') || type.eql?('passenger')
  end
end
