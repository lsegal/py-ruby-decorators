require 'decorators'
require 'force_bind'

class ClassMethod < Decorator
  def decorate(klass, meth)
    proc = klass.instance_method(meth).force_bind(klass)
    klass.define_singleton_method(meth, &proc)
    klass.send(:undef_method, meth)
  end
end
