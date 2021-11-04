local t = {
    1, 4, 4, 2, 3, 5, 6, 9, 2, 3, 4, 12, 23, 1
}

local tableUtils = {}

---
--- 删除表中满足指定条件的值
--- @param tab 'table 被操作表'
--- @param comp 'fun(val):boolean 比较函数'
function tableUtils.removeByVal(tab, comp)
    for i = #tab, 1, -1 do
        if comp(tab[i]) then
            table.remove(tab, i)
        end
    end
end

--- 遍历表
--- @param tab 'table 被操作表'
function tableUtils.showAll(tab)
    -- 遍历结果
    for i, v in pairs(t) do
        io.write(string.format('%4d', v))
    end
    print()
end

-- 遍历原始数据
tableUtils.showAll(t)

--- 比较函数
--- @param val '被判定值'
local function comp(val)
    return val == 2 or val == 3 or val == 4
end
-- 执行删除
tableUtils.removeByVal(t, comp)

-- 遍历结果
tableUtils.showAll(t)

