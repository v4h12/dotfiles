-- #############################
-- ### CUSTOM LUA LAYOUTS ###
-- #############################
-- See https://wiki.hypr.land/Configuring/Layouts/Custom-Layouts/

-- 3-pane: tall pane on the left, two stacked panes on the right
local LEFT_RATIO = 0.6725 -- width of the left pane
local TOP_RATIO = 0.3335  -- height of the top-right pane

hl.layout.register("threepane", {
    recalculate = function(ctx)
        local n = #ctx.targets
        if n == 0 then
            return
        end

        if n ~= 3 then
            -- graceful fallback for any other window count
            local cols = math.ceil(math.sqrt(n))
            for i, target in ipairs(ctx.targets) do
                target:place(ctx:grid_cell(i, cols))
            end
            return
        end

        local left = ctx:split(ctx.area, "left", LEFT_RATIO)
        local right = ctx:split(ctx.area, "right", 1 - LEFT_RATIO)
        local top = ctx:split(right, "top", TOP_RATIO)
        local bottom = ctx:split(right, "bottom", 1 - TOP_RATIO)

        ctx.targets[1]:place(left)
        ctx.targets[2]:place(top)
        ctx.targets[3]:place(bottom)
    end,
})
