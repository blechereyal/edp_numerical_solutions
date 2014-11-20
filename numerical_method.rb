require './solution.rb'
class NumericalMethod
  # takes a Solution Obj 
  attr_accessor :step, :solution
  def initialize(step,solution,&block)
    @step = step
    @solution = solution
    @numerical_method_for_n = block
    @array_of_vals = []
    @array_of_vals << @solution.y(@solution.range.begin)
    get_values
  end
  
  def points
    @solution.range.step(@step).to_a
  end
  
  def values
    @array_of_vals
  end
  
  def get_values
    (@solution.range.step(@step).to_a - [@solution.range.begin]).each do |next_point|
      @array_of_vals << @numerical_method_for_n.call(@array_of_vals.last, next_point - @step , @step )
    end
  end
  
  def error
    @error ||= get_error
  end
  
  def errors
    @errors ||= @array_of_vals.each_with_index.map do |aprox_value ,for_p|
      (aprox_value - @solution.y(self.points[for_p])).abs rescue 0
    end
    @errors
  end
  
  def get_error
    max = 0
    @array_of_vals.each_with_index do |aprox_value ,for_p|
      local_err = (aprox_value - @solution.y(self.points[for_p])).abs rescue 0
      max = local_err if local_err > max
    end
    max
  end
  
end