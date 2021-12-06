input = parse.(Int, split(readline("06.input"), ','))

function next_generation_p1(fish; renew=6, new=8)
    n_new = count(x->(x==0), fish)
    fish .-= 1
    append!(fish, ones(n_new)*new)
    fish[fish.<0] .= renew
    return fish
end

function next_generation_p2(this_gen; renew=6, new=8)
    next_gen = Dict{Int, Int}()
    for i in 0:new
        next_gen[i] = this_gen[mod1(i+2, new+1)-1]
    end
    next_gen[renew] += this_gen[0]
    return next_gen
end

# part 1
fish = copy(input)
for i in 1:80
    fish = next_generation_p1(fish)
end
length(fish)

# part 2
this_gen = Dict(i=>count(x->(x==i), input) for i in 0:8)
for i in 1:256
    this_gen = next_generation_p2(this_gen)
end
sum(values(this_gen))
