require 'decorators'

class Page < Decorator
  def decorate(klass, meth, opts = {})
    puts "Page #{meth} has options #{opts.inspect}"
  end
end