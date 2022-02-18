# Jonas August, 2/2022

#=
This problem was asked by Microsoft.

A number is considered perfect if its digits sum up to exactly 10.

Given a positive integer n, return the n-th perfect number.

For example, given 1, you should return 19. Given 2, you should return 28.
=#

" Returns n-th perfect number. "
function perfect10(n::Int)::Int
    @assert n > 0
    i = 0   # number being checked
    m = 0   # current count of perfect numbers ≤ i CHECK
    while m < n 
        i += 1
        # Convert number to digits by converting to string and then converting each digit to Int individually.
        s = 0  # sum of the converted digits
        for digit in string(i)
            s += parse(Int, digit)
        end
        if s == 10
            m += 1
        end
    end
    i
end


using Test
@test perfect10(1) == 19
@test perfect10(2) == 28

for n in 1:100
    @show n, perfect10(n)
end
