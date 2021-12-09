input = parse.(Int, reduce(vcat, permutedims.(split.(readlines("09.input"), ""))))

# part 1
function get_neighbors(ind, input)
    h, w = size(input)
    i, j = (mod1(ind,h), (ind-1)÷h+1)
    i_neighbors = [i-1, i, i+1, i]
    j_neighbors = [j, j+1, j, j-1]
    ind_neighbors = h.*(j_neighbors .- 1) .+ i_neighbors
    return input[ind_neighbors[1 .<= i_neighbors .<= h .&& 1 .<= j_neighbors .<= w]]
end

function part_1(input)
    h, w = size(input)
    risk = 0
    for ind in eachindex(input)
        if prod(input[ind] .< get_neighbors(ind, input))
            ind
            input[ind]
            get_neighbors(ind, input)
            risk += 1 + input[ind]
        end
    end
    return risk
end

part_1(input)
