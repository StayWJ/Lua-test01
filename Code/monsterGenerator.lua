---------------------------------------
-- 怪兽生成器
---------------------------------------

--- 怪兽生成器
local MonsterGenerator = {}
MonsterGenerator.__index = MonsterGenerator
-- 设置随机数种子
math.randomseed(tostring(os.time()):sub(-6):reverse())

--- 怪兽实体接口
local iMonsterBean = {
    --- 血量
    hp = 0,
    --- 攻击力
    atk = 0,
    --- 防御力
    def = 0
}

--- 生成一个小怪兽
function MonsterGenerator:new()
    local monster = {
        --- 血量
        hp = 0,
        --- 攻击力
        atk = 0,
        --- 防御力
        def = 0
    }
    setmetatable(monster, MonsterGenerator)
    monster.hp = self and self.hp or math.random(100, 1000)
    monster.atk = self and self.atk or math.random(100, 1000)
    monster.def = self and self.def or math.random(100, 1000)
    return monster
end

--- 获取小怪兽的血量
function MonsterGenerator.getHp(monster)
    return monster.hp or 0
end

--- 获取小怪兽的攻击力
function MonsterGenerator.getAtk(monster)
    return monster.atk or 0
end

--- 获取小怪兽的防御力
function MonsterGenerator.getDef(monster)
    return monster.def or 0
end

--- 展示小怪兽的基础信息
function MonsterGenerator.showInfo(monster)
    print('------------')
    print('ID =', monster)
    print('HP =', MonsterGenerator.getHp(monster))
    print('ATK =', MonsterGenerator.getAtk(monster))
    print('DEF =', MonsterGenerator.getDef(monster))
    print('------------')
end

local monster1 = MonsterGenerator:new()
MonsterGenerator.showInfo(monster1)

local monster2 = monster1:new()
MonsterGenerator.showInfo(monster2)

local monster3 = MonsterGenerator:new()
MonsterGenerator.showInfo(monster3)