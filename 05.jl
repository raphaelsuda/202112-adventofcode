input = map(readlines("05.input")) do l
    data = split(l, " -> ")
    c1 = parse.(Int, split(data[1], ','))
    c2 = parse.(Int, split(data[2], ','))
    return (x1=c1[1], y1=c1[2], x2=c2[1], y2=c2[2])
end

function get_line((x1, y1, x2, y2))
    Δx, Δy = x2-x1, y2-y1
    Δmax = maximum(abs.([Δx, Δy]))
    if Δmax == 0
        return [(x1, y1)]
    end
    return [Int.(floor.((x1+Δx/Δmax*i, y1+Δy/Δmax*i))) for i in 0:Δmax]
end

function is_ortho((x1, y1, x2, y2))
    return x1==x2 || y1==y2
end

# part 1
function part01(input)
    lines = get_line.(input[is_ortho.(input)])
    fields = Dict()
    for l in lines
        for p in l
            if p in keys(fields)
                fields[p] += 1
            else
                fields[p] = 1
            end
        end
    end
    return count(x->(x>=2), collect(values(fields)))
end

part01(input)

# part 2
function part02(input)
    lines = get_line.(input)
    fields = Dict()
    for l in lines
        for p in l
            if p in keys(fields)
                fields[p] += 1
            else
                fields[p] = 1
            end
        end
    end
    return count(x->(x>=2), collect(values(fields)))
end

part02(input)
