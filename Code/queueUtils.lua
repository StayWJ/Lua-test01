--- 队列类
local Queue = {}

--- 创建一个队列
--- 这里是用 . 的声明是为了避免子类也出现 new 的调用方法
function Queue.new()
    local queue = {front = 0, rear = 0}
    return queue
end

--- 推入一个元素
function Queue.push(queue, val)
    queue[queue.rear] = val
    queue.rear = queue.rear + 1
end

--- 推出一个元素
function Queue.pop(queue)
    -- 队列为空，直接结束
    if Queue.isEmpty(queue) then return nil end
    local result = queue[queue.front]
    queue[queue.front] = nil -- 设空，便于垃圾回收
    queue.front = queue.front + 1
    return result
end

--- 队列判空
function Queue.isEmpty(queue)
    return queue.rear == queue.front
end

--- 遍历队列
function Queue.showAll(queue)
    -- 队列为空，直接结束
    if Queue.isEmpty(queue) then return end
    -- 遍历输出
    print('开始遍历', queue)
    for i = queue.front, queue.rear - 1 do
        print('No.'..(i - queue.front + 1)..' = '..queue[i])
    end
    print('结束遍历', queue)
    print('----------')
end

local queue = Queue.new()
Queue.pop(queue)
Queue.showAll(queue)
Queue.push(queue,1)
Queue.push(queue,2)
Queue.showAll(queue)
Queue.pop(queue)
Queue.showAll(queue)

return Queue