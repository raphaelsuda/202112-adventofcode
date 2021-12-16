function parse_literal(s::AbstractString)
    bin_string = ""
    counter = 1
    last = false
    while !(last)
        bin_string = bin_string * s[5*(counter-1)+2:5*(counter-1)+5]
        if s[5*(counter-1)+1] == '0'
            last = true
        end
        counter += 1
    end
    if length(s) > 5*(counter-1)
        rest = s[5*(counter-1)+1:end]
    else
        rest = ""
    end
    return parse(Int64, bin_string; base=2), rest
end

function parse_operation(s::AbstractString)
    length_type = parse(Bool, s[1])
    if length_type
        bin_length = 11
    else
        bin_length = 15
    end
    l = parse(Int64, s[2:2+bin_length-1]; base=2)
    packet_str = s[2+bin_length:end]
    packets = Packet[]
    n = 1
    l_start = length(packet_str)
    while n ≤ l
        next_p, packet_str = Packet(packet_str)
        push!(packets, next_p)
        if length_type
            n += 1
        else
            n = l_start - length(packet_str) + 1
        end
    end
    return packets, packet_str
end

mutable struct Packet
    version::Int64
    type::Int64
    content::Vector

    function Packet(s::AbstractString)
        version = parse(Int64, s[1:3]; base=2)
        type = parse(Int64, s[4:6]; base=2)
        str = s[7:end]
        content = []
        if type == 4
            num, rest = parse_literal(str)
            push!(content, num)
        else
            packets, rest = parse_operation(str)
            append!(content, packets)
        end
        return new(version, type, content), rest
    end

    function Packet(version, type, content)
        return new(version, type, content)
    end
end

binstring(num) = join(digits(num, base=2, pad=4)[end:-1:1])
input = readline("16.input")
bin_input = join(binstring.(parse.(Int64, collect(input); base= 16)))

p, _ = Packet(bin_input)

# part 1
function add_versions(p::Packet)
    n = 0
    if p.type ≠ 4
        for p_i in p.content
            n += add_versions(p_i)
        end
    end
    n += p.version
    return n
end

add_versions(p)

# part 2
function is_literal(p::Packet)
    return p.type == 4
end

function get_num(p::Packet)
    return p.content[1]
end

function eval!(p::Packet)
    if p.type == 4
        return p
    elseif prod(is_literal.(p.content))
        numbers = get_num.(p.content)
        if p.type == 0
            res =  sum(numbers)
        elseif p.type == 1
            res = prod(numbers)
        elseif p.type == 2
            res = minimum(numbers)
        elseif p.type == 3
            res = maximum(numbers)
        elseif p.type == 5
            numbers[1] > numbers[2] ? (res = 1) : (res = 0)
        elseif p.type == 6
            numbers[1] < numbers[2] ? (res = 1) : (res = 0)
        elseif p.type == 7
            numbers[1] == numbers[2] ? (res = 1) : (res = 0)
        end
        return Packet(p.version, 4, [res])
    else
        return eval!(Packet(p.version, p.type, eval!.(p.content)))
    end
end

eval!(p)