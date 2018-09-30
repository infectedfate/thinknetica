module InstanceCounter
  def self.included(base)
    base.extend ClassMethods
    base.send :include, InstanceMethods
  end

  module ClassMethods

    attr_writer :count

    def count
      @count ||= 0
    end
  end

  module InstanceMethods

    protected

    def register_instance
      self.class.count += 1
    end
  end
end
