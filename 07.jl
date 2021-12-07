using Plots
using Statistics

input = parse.(Int, split(read("07.input", String), ','))

# part 1
sum(abs.(input.-median(input)))

# part 2
function fuel_p2(pos, dest)
    return reduce(+, 1:abs(dest-pos))
end

function part_2(crabs)
    last_res = sum(fuel_p2.(crabs, 0))
    for dest in 1:1:maximum(crabs)
        this_res = sum(fuel_p2.(crabs, dest))
        if this_res > last_res
            return last_res
        end
        last_res = this_res
    end
end

part_2(input)
