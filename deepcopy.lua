local t = {
    a = {
        a1 = 1,
        a2 = 2,
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
        -- 保存已查找到的表
        -- 这里如果放到迭代后，在环的拷贝下会导致栈溢出
        copyTabArr[temp] = result

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

        return result
    end
    return _doCopy(source)
end

local newTab = doDeepCopy(t)