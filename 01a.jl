input = parse.(Int, readlines("01.input"))
n = count(input[i+1]-input[i] > 0 for i in 1:length(input)-1)
