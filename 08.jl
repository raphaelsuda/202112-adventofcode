input = map(readlines("08.input")) do i
    data = split.(split(i, " | "), ' ')
    (patterns=data[1], output=data[2])
end

# part 1
function count_p1(line; n_count=[2, 3, 4, 7])
    return count(x->(x in n_count), length.(line.output))
end

sum(count_p1.(input))

# part 2
p = Set.(input[1].patterns)
