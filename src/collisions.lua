-- collisions

collisions = (function()
    local c = {}

    c.have_circles_collided = function(circle1, circle2)
        local distance_x = abs(circle1.x - circle2.x)
        local distance_y = abs(circle1.y - circle2.y)
        local distance = sqrt(distance_x * distance_x + distance_y * distance_y)

        return distance < circle1.r + circle2.r
    end

    return c;
end)()