# Jonas August, 2021

#=
This problem was asked by Facebook.

Given a string of round, curly, and square open and closing brackets, return whether the brackets are balanced (well-formed).

For example, given the string "([])[]({})", you should return true.

Given the string "([)]" or "((()", you should return false.
=#

#=

Observations:

- Closing bracket follows matching opening bracket.

- Brackets come in matched pairs.

- Cannot close an outer pair before inner is closed.


Recursive definition of well-formed string:

good_string
= no brackets OR
 good_string, opening bracket, good_string, matched closing bracket, good_string
  
=#

closer = Dict("(" => r"\)", "{" => r"\}", "[" => r"\]")

function isgood(s::String)
  mnone = match(r"^[^(){}[\]]*$", s)
  if !isnothing(mnone)
    #println("no brackets in \"$s\"")
    return true
  end
  mleft = match(r"[({[]", s)
  if isnothing(mleft) 
      return false
  end
  mright = match(closer[mleft.match], s)
  if isnothing(mright)
      return false
  end
  ileft = mleft.offset
  iright = mright.offset
  if ileft >= iright
      return false
  end
  sleft = s[1:ileft-1]
  smid = s[ileft+1:iright-1]
  sright = s[iright+1:end]
  #println("left=\"$sleft\" mid=\"$smid\" right=\"$sright\"")
  isgood(sleft) && isgood(smid) && isgood(sright)
end


using Test

well_formed = ["", "ab", "()", "[]", "()[]", "{}", "([])", "([])[]", "([])[]({})"]
@testset "well formed string \"$s\"" for s in well_formed
    @test isgood(s)
end

badly_formed = ["(", "}", ")(", "([)]", "((()"]
@testset "badly formed string \"$s\"" for s in badly_formed
    @test !isgood(s)
end
