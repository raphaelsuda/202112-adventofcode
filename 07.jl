using Plots
using Statistics

input = parse.(Int, split(read("07.input", String), ','))

# part 1
sum(abs.(input.-median(input)))

# part 2
function fuel_p2(pos, dest)
    diff = abs(pos-dest)
    return (diff+1)*diff/2
end

minimum([sum(fuel_p2.(input, Int(floor(mean(input))))) sum(fuel_p2.(input, Int(ceil(mean(input)))))])
