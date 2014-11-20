require './solution.rb'
require './numerical_method.rb'

def function1(x,y)
  x-2*y 
end

CONSTANT_FOR_ME = -((Math::E ** 16) * 21) / 2
N = [5, 10, 20, 50, 100, 200, 500, 1000]

solution = Solution.new(CONSTANT_FOR_ME, (8..9)) do |const,t|
  (0.5) * (t - 0.5 - (const / (Math::E ** (2*t))) )
end

def methods(step_value,solution)
  methods = [
    NumericalMethod.new(step_value, solution) do |last_val,last_point,step|
      last_val + step * function1(last_point,last_val) 
    end, 
    NumericalMethod.new(step_value, solution) do |last_val,last_point,step|
      last_val + step * function1(last_point, last_val + step * function1(last_point,last_val))
    end,
    NumericalMethod.new(step_value, solution) do |last_val,last_point,step|
      last_val + (step/2) * (function1(last_point,last_val) + function1(last_point+step, last_val + step* function1(last_point,last_val)))
    end,
    NumericalMethod.new(step_value, solution) do |last_val,last_point,step|
      last_val + step * (function1(
      last_point + (step/2),
      last_val + (step/2)*function1(last_point,last_val)
      ))
    end,
    NumericalMethod.new(step_value, solution) do |last_val,last_point,step|
      m1 = step * function1(last_point,last_val)
      m2 = step * function1(last_point + step / 2, last_val + m1 /2 )
      m3 = step * function1(last_point + step / 2, last_val + m2 /2 )
      m4 = step * function1(last_point + step , last_val + m3)
      last_val + (1.0/6) * (m1 + 2*m2 + 2*m3 + m4)
    end
    
  ]
end
# 
# puts '"' + N.join('","') + '"'
# 5.times do |method_no|
#   N.map{|a| 1.0 / (a+1)}.each do |step_value| 
#     print '"' +  methods(step_value,solution)[method_no].error.to_s + '"' + ','
# 
#   end
#   puts
# end
# puts 

1.times do |method_no|
  N.map{|a| 1.0 / (a+1)}.each do |step_value| 
    puts methods(step_value,solution)[method_no].errors
  end
  puts 
end





