# Jonas August, 2/2022

#=
This problem was asked by Amazon.

Given a N by M matrix of numbers, print out the matrix in a clockwise spiral.

For example, given the following matrix:

[[1,  2,  3,  4,  5],
 [6,  7,  8,  9,  10],
 [11, 12, 13, 14, 15],
 [16, 17, 18, 19, 20]]

You should print out the following:

1
2
3
4
5
10
15
20
19
18
17
16
11
6
7
8
9
14
13
12

=#

function line(m)
    for x in m
        println(x)
    end
end

function spiral(A::AbstractMatrix)
    m, n = size(A)
    if m == 0 || n == 0 return end
    if m > 0 line(A[begin,begin:end-1]) end
    if n > 1 line(A[begin:end-1,end]) end
    if m > 1 line(A[end,end:-1:begin+1]) end
    if n > 0 line(A[end:-1:begin+1,begin]) end
    spiral(A[begin+1:end-1,begin+1:end-1])
end

A = reshape(1:20, 5, 4)'
spiral(A)
