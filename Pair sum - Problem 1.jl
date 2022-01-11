# Jonas August 2021

#=

This problem was recently asked by Google.

Given a list of numbers and a number k, return whether any two numbers from the list add up to k.

For example, given [10, 15, 3, 7] and k of 17, return true since 10 + 7 is 17.

Bonus: Can you do this in one pass?

=#

# Two pass method
function haspair2(list, sum)
   for i in 1:length(list)
      for j in 1:length(list)
        if j == 1
	    continue
	end
	if list[i] + list[j] == sum
	    return true
	end
      end
   end
   false
end

#=
TODO: single-pass
I can see quadratic-time method with only a single pass of list, by introducing a pass on a different array, so not really an improvement IMO.
=#




using Test

@test haspair2([10, 15, 3, 7], 17)
@test !haspair2([10, 15, 3, 7], 26)
