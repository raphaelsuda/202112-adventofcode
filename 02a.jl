function read_command(line::AbstractString)
    s = split(line)
    return s[1], parse(Int, s[2])
end

function move((command, value), (pos, depth))
    if command == "up"
        return pos, depth-value
    elseif command == "down"
        return pos, depth+value
    else
        return pos+value, depth
    end
end

input = read_command.(readlines("02.input"))

pos = (0,0)
for c in input
    pos = move(c, pos)
end

solution = pos[1] * pos[2]
