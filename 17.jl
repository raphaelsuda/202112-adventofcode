function start_probe((v_x, v_y), (xmin, xmax, ymin, ymax); start_pos=[0 0])
    trajectory = start_pos
    next_pos = [start_pos[1]+v_x start_pos[2]+v_y]
    while next_pos[1] <= xmax && next_pos[2] >= ymin
        trajectory = vcat(trajectory, next_pos)
        v_x = maximum([v_x-1, 0])
        v_y -= 1
        next_pos = [next_pos[1]+v_x next_pos[2]+v_y]
    end
    return trajectory
end

function is_intarget(trajectory, (xmin, xmax, ymin, ymax))
    if xmin <= trajectory[end, 1] <= xmax && ymin <= trajectory[end, 2] <= ymax
        return true
    else
        return false
    end
end

# part 1
function find_moststylish((xmin, xmax, ymin, ymax); start=[0 0])
    min_vx = Int64(ceil(-0.5 + sqrt(0.25 + 2*(xmin-start[1]))))
    max_vx = Int64(floor(-0.5 + sqrt(0.25 + 2*(xmax-start[1]))))
    min_vy = 1
    max_vy = 200 
    max_y = 0
    for v_x in min_vx:max_vx
        for v_y in min_vy:max_vy
            trajectory = start_probe((v_x, v_y), target)
            if is_intarget(trajectory, target)
                max_y = maximum([max_y, maximum(trajectory[:,2])])
            end
        end
    end
    return max_y
end

target = Tuple(parse.(Int64, match(r"target area: x=(\d*)..(\d*), y=(-?\d*)..(-?\d*)", readline("17.input")).captures))
find_moststylish(target)

# part 2
function count_targets((xmin, xmax, ymin, ymax); start=[0 0])
    min_vx = Int64(ceil(-0.5 + sqrt(0.25 + 2*(xmin-start[1]))))
    max_vx = xmax - start[1]
    min_vy = ymin - start[2]
    max_vy = 200
    counter = 0
    for v_x in min_vx:max_vx
        for v_y in min_vy:max_vy
            trajectory = start_probe((v_x, v_y), target)
            if is_intarget(trajectory, target)
                counter += 1
            end
        end
    end
    return counter
end

count_targets(target)