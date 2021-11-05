-- 设置随机数种子
math.randomseed(tostring(os.time()):sub(-6):reverse())
--- 地图尺寸
local MAP_SIZE = 50
--- 起点坐标
local START_POS = {x = 1, y = 1}
--- 终点坐标
local END_POS = {x = MAP_SIZE, y = MAP_SIZE}
local START_TAG, END_TAG,ROAD_TAG, WALL_TAG = '*', '!', '+', '-'
local map = {}

--- 生成地图
local function initMap(tMap)
    for i = 1, MAP_SIZE do
        tMap[i] = {}
        for j = 1, MAP_SIZE do
            tMap[i][j] = {
                x = i,
                y = j,
                tag = math.random(10) < math.random(10) * 2 and ROAD_TAG or WALL_TAG,
            }
        end
    end
    -- 设置终点和起点的标记
    tMap[START_POS.x][START_POS.y].tag = START_TAG
    tMap[END_POS.x][END_POS.y].tag = END_TAG
end

--- 显示地图
local function showMap(tMap)
    for i = 1, MAP_SIZE do
        for j = 1, MAP_SIZE do
            io.write(tMap[i][j].tag..' ')
        end
        print()
    end
end

--- 获取两点间的距离
local function getDistance(pos1, pos2)
    return math.abs(pos1.x - pos2.x) + math.abs(pos1.y - pos2.y)
end

--- 获取当前节点的估值
--- @param pos '坐标'
--- @return number, number, number '起点估值', '终点估值', '总估值'
local function getPathVal(pos, curPos)
    local curVal = curPos.startVal and curPos.startVal or 0
    local startVal = getDistance(pos, curPos) + curVal
    local endVal = getDistance(pos, END_POS)
    return startVal, endVal, startVal + endVal
end

--- 二分查找列表
local function findFirstMaxIndex(list, val)
    -- 列表为空
    if #list == 0 then return nil end
    -- 检查表头和表尾
    if list[1].totalVal > val.totalVal then return 1 end
    local size = #list
    if list[size].totalVal < val.totalVal then return nil end
    -- min 一定是小于等于查找值的索引
    -- max 一定是大于查找值的索引
    local minIndex, maxIndex = 1, size
    -- 查找
    while maxIndex - minIndex > 1 do
        local midIndex = math.floor((minIndex + maxIndex) / 2)
        local midNode = list[midIndex]
        if midNode.totalVal >= val.totalVal then
            maxIndex = midIndex
        else
            minIndex = midIndex
        end
    end
    return maxIndex
end

--- 按估值从小到大保持有序插入
local function insert(list, val)
    if type(list) ~= 'table' then
        list = {}
    end
    ----[[
    ---- 遍历找到第一个大于val的位置
    local pos = findFirstMaxIndex(list, val)
    if pos then
        table.insert(list, pos, val)
    else
        table.insert(list, val)
    end
    --]]

    --[[
    -- 列表为空或都不比他小走这里
    if #list == 0 or list[#list].totalVal < val.totalVal then
        table.insert(list, val)
        return
    end
    -- 遍历找到第一个大于等于val的位置
    -- 不包括等于的话，相同权重的情况下，越早入表的在越前面
    for i, v in ipairs(list) do
        if v.totalVal >= val.totalVal then
            table.insert(list, i, val)
            return
        end
    end
    --]]
end

--- 判断一个点是否是终点
local function isEnd(node)
    return node.x == END_POS.x and node.y == END_POS.y
end

--- 返回一个点的临近点
local function getNeighbours(pos)
    local list = {}
    for i, x in ipairs({pos.x + 1, pos.x - 1}) do
        if x > 0 and x <= MAP_SIZE then
            table.insert(list, { x = x, y = pos.y })
        end
    end
    for j, y in ipairs({pos.y - 1, pos.y + 1}) do
        if y > 0 and y <= MAP_SIZE then
            table.insert(list, { x = pos.x, y = y })
        end
    end
    return list
end

--- 搜索终点路径
local function searchPath(tMap)
    -- 待检查列表
    local openList = {}
    local curNode = tMap[START_POS.x][START_POS.y]
    -- 插入起点
    insert(openList, curNode)

    -- 当前节点不是终点 且 待检查列表不为空
    while not isEnd(curNode) and #openList ~= 0 do
        --print('--访问开始', curNode.x, curNode.y)
        -- 设置当前节点访问状态
        curNode.isVisit = true
        -- 移除当前节点
        table.remove(openList, 1)
        -- 检查节点状态
        local function doCheck(node)
            -- 是墙，不可达
            if node.tag == WALL_TAG then return end
            -- 访问过，直接结束
            if node.isVisit then return end

            -- 设置估值
            local startVal, endVal, totalVal = getPathVal(node, curNode)
            -- 原本无路径，或原路径代价更高
            if node.totalVal == nil or node.totalVal > totalVal then
                node.totalVal = totalVal
                node.startVal = startVal
                node.endVal = endVal
                -- 设置当前节点为他的父节点
                node.parent = curNode
            end

            -- 不在列表中，加入待检查列表
            if node.isOpen ~= true then
                insert(openList, node)
            end

            --print('----入栈了', node.x, node.y, node.totalVal)
            node.isOpen = true
        end
        
        -- 遍历邻近可达节点
        local function doVisit()
            local checkList = getNeighbours(curNode)
            for i, pos in ipairs(checkList) do
                local node = tMap[pos.x][pos.y]
                doCheck(node)
            end
        end

        -- 遍历检查
        doVisit()
        --print('--访问结束', curNode.x, curNode.y)
        --print('------')
        -- 没有待检查节点了，找不到路径
        if #openList == 0 then break end
        -- 重新设置当前节点
        curNode = openList[1]
    end

    if curNode.tag == END_TAG then
        print('找到了')
        local p = curNode
        while p do
            p.tag = '●'
            p = p.parent
        end
        showMap(tMap)
    else
        print('无法到达')
    end
end

initMap(map)
showMap(map)
searchPath(map)
