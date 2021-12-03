input = readlines("03.input")
groups = [[parse(Bool, l[i]) for l in input] for i in 1:length(input[1])]

binstring(b) = join([i ? '1' : '0' for i in b])

n_ones = count.(groups)
gamma = parse(Int, binstring(n_ones .> length(input)/2); base=2)
epsilon = parse(Int, binstring(n_ones .< length(input)/2); base=2)

gamma * epsilon
