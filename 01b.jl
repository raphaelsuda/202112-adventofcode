input = parse.(Int, readlines("01.input"))
sliding_sum = [sum(input[i:i+2]) for i in 1:length(input)-2]
n = count(sliding_sum[i+1]-sliding_sum[i] > 0 for i in 1:length(sliding_sum)-1)
