input = readlines("03.input")

function most_common(strings, pos)
    values = [s[pos] for s in strings]
    n_ones = count(x->(x=='1'), values)
    if n_ones >= length(strings)/2
        mc = '1'
    else
        mc = '0'
    end
    return strings[values.==mc]
end

function least_common(strings, pos)
    values = [s[pos] for s in strings]
    n_ones = count(x->(x=='1'), values)
    if n_ones >= length(strings)/2
        mc = '0'
    else
        mc = '1'
    end
    return strings[values.==mc]
end

function rating(f, lines)
    pos = 1
    while length(lines) > 1
        lines = f(lines, pos)
        pos +=1
    end
    return parse(Int, lines[1]; base = 2)
end

rating(most_common, input) * rating(least_common, input)
