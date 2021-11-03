local t = {
    a = {
        a1 = 1,
        a1 = 2,
    },
    b = 2,
    c = {
        c1 = 2,
        c2 = {
             c3 = "c3"
        },
    },
}

local function doDeepCopy(source)
    local copyTabArr = {}
    local function _doCopy(temp)
        -- 不是表类型直接返回
        if type(temp) ~= 'table' then
            return temp
        end
        
        -- 1、可能是重复的表
        if copyTabArr[temp] then
            return copyTabArr[temp]
        end
        
        local result = {}
        -- 2、可能有元表
        local tMeta = getmetatable(temp)
        -- 拷贝元表
        if tMeta then
            setmetatable(result, _doCopy(tMeta))
        end

        -- 3、迭代表，拷贝
        for k, v in pairs(temp) do
            result[k] = _doCopy(v)
        end

        -- 保存已拷贝的表
        copyTabArr[temp] = result
        return result
    end
    return _doCopy(source)
end

local newTab = doDeepCopy(t)