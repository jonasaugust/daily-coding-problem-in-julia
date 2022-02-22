# Jonas August, 2/2022

#=
This problem was asked by Google.

Given the head of a singly linked list, reverse it in-place.
=#

mutable struct Node
    value
    next::Union{Nothing, Node}
end

" 
Reverse singly-linked list in place.

           l
nothing    n1 -> n2 -> n3 -> ... -> nmax -> nothing
rev        temp

                 l
nothing    n1 -> n2 -> n3 -> ... -> nmax -> nothing
rev        temp

                 l
nothing <- n1    n2 -> n3 -> ... -> nmax -> nothing
rev        temp

                 l
nothing <- n1    n2 -> n3 -> ... -> nmax -> nothing
           rev   temp
"
function reverselist(l::Union{Nothing, Node})
    rev = nothing
    while !isnothing(l)
        temp = l
        l = l.next
        temp.next = rev
        rev = temp
    end
    rev
end


function printlist(l::Union{Nothing, Node})
    while !isnothing(l)
        println(l.value)
        l = l.next
    end
end

lists = [nothing, Node(1, nothing), Node(1, Node(3, Node(5, nothing)))]
for l in lists
    @show l
    printlist(l)
    println()
    rev = reverselist(l)
    @show rev
    printlist(rev)
    println()
    println()
end
