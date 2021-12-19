import Base.+
import Base.splice!

mutable struct SnailfishNumber
    numbers::Vector{Int64}
    level::Vector{Int64}

    SnailfishNumber(numbers, level) = new(numbers, level)

    function SnailfishNumber(s::AbstractString)
        numbers = Int64[]
        level = Int64[]
        n_open = 0
        for c in s
            if c == '['
                n_open += 1
            elseif c == ']'
                n_open -= 1
            elseif c ≠ ','
                push!(numbers, parse(Int64, c))
                push!(level, n_open)
            end
        end
        return new(numbers, level)
    end
end

function reduce!(s::SnailfishNumber)
    while !(prod(s.level.<=4))
        i = findfirst(>(4), s.level)
        if i == 1
            s.numbers[i+2] += s.numbers[i+1]
        elseif i == length(s.numbers)-1
            s.numbers[i-1] += s.numbers[i]
        else
            s.numbers[i-1] += s.numbers[i]
            s.numbers[i+2] += s.numbers[i+1]
        end
        popat!(s.numbers, i+1)
        popat!(s.level, i+1)
        s.numbers[i] = 0
        s.level[i] -= 1
    end
    return s
end

function splice!(s::SnailfishNumber)
    if !(prod(s.numbers.<=9))
        i = findfirst(>(9), s.numbers)
        n = s.numbers[i]/2
        s.numbers[i] = Int64(floor(n))
        insert!(s.numbers, i+1, Int64(ceil(n)))
        s.level[i] += 1
        insert!(s.level, i+1, s.level[i])
    end
    return s
end

function +(s1::SnailfishNumber, s2::SnailfishNumber)
    numbers = [s1.numbers; s2.numbers]
    level = [s1.level; s2.level] .+ 1
    s = SnailfishNumber(numbers, level)
    while !(prod(numbers.<=9)) || !(prod(level.<=4))
        reduce!(s)
        splice!(s)
    end
    return s
end

function magnitude(s::SnailfishNumber)
    for n in 4:-1:1
        while !(prod(s.level.<=n-1))
            i = findfirst(==(n), s.level)
            s.numbers[i] = s.numbers[i]*3 + popat!(s.numbers, i+1)*2
            s.level[i] -= 1
            popat!(s.level, i+1)
        end
    end
    return s.numbers[1]
end

# part 1
nums = SnailfishNumber.(readlines("18.input"))
magnitude(reduce(+, nums))

# part 2
maximum([magnitude(s1+s2) for s1 in nums, s2 in nums])