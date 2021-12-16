function find_best(d)
    return collect(keys(d))[argmin(collect(values(d)))]
end

function get_neighbors!(candidates, visited, grid)
    h, w = size(grid)

    pos = find_best(candidates)
    push!(visited, pos)
    if pos[1] ≠ 1
        new_pos = pos - CartesianIndex(1,0)
        if new_pos ∉ visited
            val = candidates[pos] + grid[new_pos]
            if new_pos ∉ keys(candidates)
                candidates[new_pos] = val
            elseif  val < candidates[new_pos]
                candidates[new_pos] = val
            end
        end
    end
    if pos[1] ≠ h
        new_pos = pos + CartesianIndex(1,0)
        if new_pos ∉ visited
            val = candidates[pos] + grid[new_pos]
            if new_pos ∉ keys(candidates)
                candidates[new_pos] = val
            elseif  val < candidates[new_pos]
                candidates[new_pos] = val
            end
        end
    end
    if pos[2] ≠ 1
        new_pos = pos - CartesianIndex(0,1)
        if new_pos ∉ visited
            val = candidates[pos] + grid[new_pos]
            if new_pos ∉ keys(candidates)
                candidates[new_pos] = val
            elseif  val < candidates[new_pos]
                candidates[new_pos] = val
            end
        end
    end
    if pos[2] ≠ w
        new_pos = pos + CartesianIndex(0,1)
        if new_pos ∉ visited
            val = candidates[pos] + grid[new_pos]
            if new_pos ∉ keys(candidates)
                candidates[new_pos] = val
            elseif  val < candidates[new_pos]
                candidates[new_pos] = val
            end
        end
    end
    delete!(candidates, pos)
end

## part 1
# input
input = parse.(Int64, reduce(vcat, permutedims.(collect.(readlines("15.input")))))
# solution
candidates = Dict(CartesianIndex(1,1)=>0)
visited = Set{CartesianIndex}()
while find_best(candidates).I ≠ size(input)
    get_neighbors_p2!(candidates, visited, input)
end

## part 2
# input
n_add = reduce(hcat,[collect(i-1:i+3) for i in 1:5])
h, w = size(input)
new_input = zeros(Int64, h*5, w*5)
for i in 1:5
    for j in 1:5
        new_input[h*(i-1)+1:h*i, w*(j-1)+1:w*j] = mod1.(input.+n_add[i,j], 9)
    end
end
# solution
candidates = Dict(CartesianIndex(1,1)=>0)
visited = Set{CartesianIndex}()
while find_best(candidates).I ≠ size(new_input)
    get_neighbors!(candidates, visited, new_input)
end