# Jonas August 1/2022

#=

This problem was asked by Google.

The power set of a set is the set of all its subsets. Write a function that, given a set, generates its power set.

For example, given the set {1, 2, 3}, it should return {{}, {1}, {2}, {3}, {1, 2}, {1, 3}, {2, 3}, {1, 2, 3}}.

You may also use a list or array to represent a set.

=#

#=

The possible subsets are equivalent to all possible binary indicator vectors, where each bit represents presence (1) or absence (0) of a given element.

Thus 2^n possibilities entries in the power set.

What about repeated elements, and thus indistinguishable subsets?

I will assume that we are to compute the power set _of a set_ (which has distinct elements, by definition), that the array representing the set has unique elements (no repeated elements).  I can test this.

=#


#=

Another approach (more complex, not implemented):

- Let n be length of v.
- Let p be the power set of v, initially empty.
- Each entry in p will be a subset of the elements of v.
- Generate all n-bit patterns, and for each bit pattern select the components of v based where there are 1's in the pattern, and add it to p.

How to generate bit pattern?
Count from 0 through 2^n-1 in an (unsigned?) int of sufficient bits, or create a length n bit array, and "count".  If we use int representation, then counting is built-in.  If we make binary array, then we have to implement increment (with carry).

=#

"Construct array of all subsets of v"
function powerset(v)
   # TODO: assert that there are no repeated elements in v
   p = [[]]
   for item in v
       n = []   # new sets with item appended
       for set in p
           push!(n, push!(copy(set), item))
       end
       push!(p, n...)   # combine p and n
   end
   p
end


using Test
@test powerset([]) == [[]]
@test powerset([1]) == [[], [1]]
@test powerset([1,2]) == [[],[1],[2],[1,2]]
# Set needed because ordering in computed powerset is different than test case.
@test Set(powerset([1,2,3])) == Set([[],[1],[2],[3],[1,2],[1,3],[2,3],[1,2,3]])
