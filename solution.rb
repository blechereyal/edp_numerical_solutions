class Solution  
  attr_accessor :range,:constant
  def initialize(constant,range,&block)
    @constant = constant
    @range = range
    @function = block
  end
  
  def y(x)
    @function.call(@constant,x)
  end
end
