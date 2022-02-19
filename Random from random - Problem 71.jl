# Jonas August, 2/2022

#=
This problem was asked by Two Sigma.

Using a function rand7() that returns an integer from 1 to 7 (inclusive) with uniform probability, implement a function rand5() that returns an integer from 1 to 5 (inclusive).
=#

rand7() = rand(1:7)

function rand5()
    x = 6
    while x > 5  # Keep sampling uniformly on 1:7 until in range 1:5
        x = rand7()
    end
    x
end

sample = [rand5() for _ in 1:50000]

" Calculate 5 bin histogram. "
function hist5(sample::Vector{Int})
    h = zeros(Int, 5)
    for x in sample
        h[x] += 1
    end
    h
end

# Test uniformity of probability: All bins should have similar counts.
println(hist5(sample))
