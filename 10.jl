using Statistics
input = readlines("10.input")

const brackets = Dict('('=>')',
                      '['=>']',
                      '{'=>'}',
                      '<'=>'>')

const score_p1 = Dict(')'=>3,
                   ']'=>57,
                   '}'=>1197,
                   '>'=>25137)

const score_p2 = Dict(')'=>1,
                   ']'=>2,
                   '}'=>3,
                   '>'=>4)

# part 1
function syntax_score(line)
    open_brackets = Char[]
    for c in line
        if c in keys(brackets)
            push!(open_brackets, c)
            continue
        elseif c ≠ brackets[open_brackets[end]]
            return score_p1[c]
        else
            pop!(open_brackets)
        end
    end
    return 0
end
sum(syntax_score.(input))

# part 2
function bracket_score(line)
    open_brackets = Char[]
    for c in line
        if c in keys(brackets)
            push!(open_brackets, c)
            continue
        else
            pop!(open_brackets)
        end
    end
    score = 0
    for b in open_brackets[end:-1:1]
        score *= 5
        score += score_p2[brackets[b]]
        @show brackets[b]
    end
    return score
end
Int64(median(bracket_score.(input[syntax_score.(input) .== 0])))