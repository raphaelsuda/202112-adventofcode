mutable struct BingoCard
    numbers::Array{Int,2}
    hits::Array{Bool,2}
    bingo::Bool
    function BingoCard(numbers)
        new(numbers, falses(size(numbers)), false)
    end
end

function check!(c::BingoCard)
    for i in 1:size(c.hits, 1)
        if sum(c.hits[i,:]) == 5
            c.bingo = true
            break
        elseif sum(c.hits[:,i]) == 5
            c.bingo = true
            break
        end
    end
    return c
end

function cross!(c::BingoCard, n::Number)
    ind = findfirst(x->(x==n), c.numbers)
    if !isnothing(ind)
        c.hits[ind] = true
    end
    check!(c)
    return c
end

input = split(read("04.input", String), "\n\n")

numbers = parse.(Int, split(input[1], ','))
cards = map(input[2:end]) do c
    BingoCard(parse.(Int, reduce(vcat, permutedims.(split.(split(c, '\n'))))))
end

bingo = false
counter = 0
while !bingo
    counter += 1
    cross!.(cards, numbers[counter])
    for c in cards
        if c.bingo
            println("BINGO!")
            bingo = true
            println(sum(c.numbers[.!c.hits]) * numbers[counter])
            break
        end
    end
end
