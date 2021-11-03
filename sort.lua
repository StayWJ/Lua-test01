local data = {
    {age = 1, name = "aa", stage = 2},
    {age = 1, name = "bb", stage = 3},
    {age = -1, name = "bb", stage = 2},
    {age = 4, name = "cd", stage = 33},
    {age = 1, name = "cc", stage = 21},
    {age = 5, name = "dc", stage = 44},
    {age = 5, name = "beb", stage = 1},
}

-- 比较函数
local function comp(a, b)
    -- 当 age 不相等时，返回 age 对比值
    if a.age ~= b.age then return a.age < b.age end
    -- 当 age 相等且 stage 不相等时，返回 stage 对比值
    if a.stage ~= b.stage then return a.stage < b.stage end
    -- 当 age 和 stage 都相等时，返回 name 对比值
    return a.name < b.name

    -- 错误写法，因为比较函数不满足非对称
    --return a.age < b.age or a.stage < b.stage or a.name < b.name

    -- 传统写法
    --if a.age < b.age then
    --    return true
    --elseif a.age == b.age then
    --    if a.stage < b.stage then
    --        return true
    --    elseif a.stage == b.stage then
    --        return a.name < b.name
    --    end
    --end
    --return false
end

table.sort(data, comp)

-- 遍历输出
for i, v in pairs(data) do
    print(i, v.age..'-'..v.stage..'-'..v.name)
end