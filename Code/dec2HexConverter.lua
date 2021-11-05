---------------------------------------
-- 进制转换
---------------------------------------

--- 十进制转十六进制
--- @param num 'number 被操作数'
--- @return number
local function doDec2Hex(num)
    local type = type(num)
    if type ~= 'number' then
        --error('参数格式错误')
        return 0
    end
    return string.format('%X', num)
end

print(doDec2Hex(15))
print(doDec2Hex('10'))
print(doDec2Hex('a'))