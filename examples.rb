require 'class_method_decorator'

class Foo
  @classmethod.()
  def bar
    puts "class method #{self}.bar: #{method(:bar)}"
  end
end

Foo.bar
# => "class method Foo.bar: #<Method: Foo.bar>"

#-----------------------------------------------

require 'servlet_decorator'

class MyServlet
  @page.(method: :get, formats: [:html, :json])
  def index
  end
  
  @page.(method: :post)
  def create
  end
end

# Prints:
#   Page index has options {:method=>:get, :formats=>[:html, :json]}
#   Page create has options {:method=>:post}