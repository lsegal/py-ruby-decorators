class Decorator
  class << self
    attr_reader :decorators
    attr_accessor :current_decorator
    def inherited(subclass) (@decorators ||= []).push(subclass.new) end
  end
  
  def call(*args, &block)
    Decorator.current_decorator = [self, args, block]
  rescue => e
    lines = e.backtrace
    lines.shift
    e.set_backtrace(lines)
    raise e, []
  end
end

class MyDecorator < Decorator
  def decorate(klass, meth, opts = {}) p opts end
end

class Object
  def self.inherited(subclass)
    Decorator.decorators.each do |decorator|
      name = decorator.class.to_s.split("::").last.downcase
      subclass.instance_variable_set("@#{name}", decorator)
    end
  end
  
  def self.method_added(meth)
    if obj = Decorator.current_decorator
      obj[0].decorate(self, meth, *obj[1], &obj[2])
    end
  rescue ArgumentError => e
    raise ArgumentError, "invalid `#decorate` implementation in #{obj[0].class}", e.backtrace
  ensure
    Decorator.current_decorator = nil
  end
end
