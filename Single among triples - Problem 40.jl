# Jonas August 1/2022

#=
This problem was asked by Google.

Given an array of integers where every integer occurs three times except for one integer, which only occurs once, find and return the non-duplicated integer.

For example, given [6, 1, 3, 3, 3, 6, 6], return 1. Given [13, 19, 13, 13], return 19.

Do this in O(N) time and O(1) space.
=#

#=
Assume that the array is correctly formed (one single among triples; no doubles, quadruples, etc.; only integers).

There are only at most (n-1)/3 + 1 unique numbers.

n = 3*m+1 is odd if m even and vice versa.

=#

#=
If y is the single entry, then the sum of the remaining entries is divisible by three.  Let x\y denote set x with y removed.

y is unique in in x => (sum of z s.t. z in x\y) mod 3 = 0

This is necessary condition for identifying y, but is it sufficient?  No!  Consider x=[13,19,13,13].  Try y=13.  Then sum of x\y is 19+13+13 = 45 which is divisible by 3.  Argh!

But maybe there's some function of the elements that can be used instead?

=#

"Find that integer in input array x that has no match, while all other elements come in three, in no particular order.  Takes O(n) time, O(1) space, where n = length of the array."
function single_among_triples_BAD(x::Vector{Int})::Int
    @error("Broken")
    s = sum(x)
    for y in x
        if (s-y)%3 == 0  # Is sum over x\y divisible by 3?
            println("s = $s, y = $y")       
            return y
        end
    end
    @error("This line should never be reached for well-formed input.")
end

#=

If a,b are integers, then cube root of aab is integer iff b = a?

Relevance Fermat's last theorem?
x^k + y^k = z^k has no positive integer solutions x,y,z for integer k>2.
Try k = 3 and cube entries?

=#

"Find that integer in input array x that has no match, while all other elements come in three, in no particular order.  Takes O(n) time, O(1) space, where n = length of the array."
function single_among_triples_fast(x::Vector{Int})::Int
    # TODO: allow zeros and negatives
    if any(x .== 0) @error("No zeroes allowed") end
    if any(x .< 0) @error("No negatives allowed") end
    p = 1
    for y in x
        p *= y
    end
    for y in x
        # TODO: CHECK that this always works
        c = (p/y)^(1/3)
	# TODO: what tolerance always gives correct results?
        if abs(c-round(c)) < 1e-7    # is c approximately an integer?
            #println("p = $p, y = $y")       
            return y
        end
    end
    @error("This line should never be reached for well-formed input.")
end




"Find that integer in input array x that has no match, while all other elements come in three, in no particular order.  Takes O(n^2) time, O(1) space, where n = length of the array."
function single_among_triples_brute_force(x::Vector{Int})::Int
    for i in 1:length(x)
       matched = false
       for j in i+1:length(x)
           if x[j] == x[i]
	       matched = true
	       break
	   end
       end
       #println(matched)
       if !matched
           return x[i]
       end
    end
    @error("This line should never be reached for well-formed input.")
end

#=
Other False starts:

Not O(1) space:

- Convert to linked list.  Pick first element and scan for match and delete matches if found, then start again.  Must end up with unmatched number at beginning.

x[i[1]] is unique in x[:]
x[i[2]] == x[i[3]] == x[i[4]]
x[i[5]] == x[i[6]] == x[i[7]]
...

x[i[1]] + sum(j = 2:3:n) 3*x[i[j]]

Not O(n) time:

- Sort.  Triples will cluster, so linearly scan for the single.

=#

# TODO: Construct random inputs

using Test

for single_among_triples in [single_among_triples_brute_force,single_among_triples_fast]
  # @test @test single_among_triples([]) == ?  not defined? exception?
  @test single_among_triples([19]) == 19
  @test single_among_triples([13, 19, 13, 13]) == 19
  @test single_among_triples([6, 1, 3, 3, 3, 6, 6]) == 1
end