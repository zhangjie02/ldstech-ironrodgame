require("Cocos2d")

local GameLayer = class("GameLayer", function()
    return cc.LayerColor:create(cc.c4b(255,255,255,255))
end)

function GameLayer:ctor()
end

function GameLayer:init()
    self.frameIndex = 0
    self.nextKeyFrameIndex = math.random(0, 9)
    local visibleSize = cc.Director:getInstance():getVisibleSize()
    
    local bg = cc.Sprite:create("clouds.jpg")
    bg:setPosition(visibleSize.width / 2, 0)
    self:addChild(bg)
    
    local bg2 = cc.Sprite:create("clouds.jpg")
    bg2:setPosition(visibleSize.width / 2, 1136)
    self:addChild(bg2)
    
    local rod = cc.Sprite:create("IronRod.png")
    rod:setScale(.35,1)
    rod:setPosition(visibleSize.width / 2, visibleSize.height / 2)
    self:addChild(rod)
    
    local player = cc.Sprite:create("player.png")
    player:setPosition(visibleSize.width / 4, visibleSize.height / 8)
    player:setPhysicsBody(cc.PhysicsBody:createBox(cc.size(20,50)))
    self:addChild(player)
    
    self.touchListener = cc.EventListenerTouchOneByOne:create()
    
    local function onTouch(touch, event)
        if (touch:getLocation().x < visibleSize.width / 2) then
            player:setPosition(visibleSize.width / 4, visibleSize.height / 8)
        else
            player:setPosition(visibleSize.width - (visibleSize.width / 4), visibleSize.height / 8)
        end
        return true
    end

    self.touchListener:registerScriptHandler(onTouch,cc.Handler.EVENT_TOUCH_BEGAN)
    cc.Director:getInstance():getEventDispatcher():addEventListenerWithSceneGraphPriority(self.touchListener, self)
    
    self.contactListener = cc.EventListenerPhysicsContact:create()
    
    local function onContactBegin(contact)
        print("Contact")
        self:unscheduleUpdate()

        cc.Director:getInstance():getEventDispatcher():removeEventListener(self.touchListener)
        cc.Director:getInstance():getEventDispatcher():removeEventListener(self.contactListener)

        cc.Director:getInstance():replaceScene(require("MenuScene").create())
    end
    
    self.contactListener:registerScriptHandler(onContactBegin, cc.Handler.EVENT_PHYSICS_CONTACT_BEGIN);
    local eventDispatcher = self:getEventDispatcher()
    eventDispatcher:addEventListenerWithSceneGraphPriority(self.contactListener, self);
    
    local function update()   
        bg:setPositionY(bg:getPositionY() - 5)
        bg2:setPositionY(bg2:getPositionY() - 5)        
        
        if bg:getPositionY() <= ( -1136 / 2) then
            bg:setPositionY(bg2:getPositionY() + 1136)
        end
        
        if bg2:getPositionY() <= ( -1136 / 2) then
            bg2:setPositionY(bg:getPositionY() + 1136)
        end
        
        self.frameIndex = self.frameIndex + 1
        if self.frameIndex >= self.nextKeyFrameIndex   then
            self:addItems()
            self:resetTimer()
        end
        
    end

    self:scheduleUpdateWithPriorityLua(update, 0);
    
end

function GameLayer:addItems()
    local visibleSize = cc.Director:getInstance():getVisibleSize()
    
    local type = math.random(0,100)
    
    local item = require("Item").new()
    item:init(type)
    self:addChild(item)
    if type > 50 then   
        item:setPosition(visibleSize.width / 4, visibleSize.height)
    else
        item:setPosition(visibleSize.width * .75, visibleSize.height)
    end
end

function GameLayer:resetTimer()
    self.frameIndex = 0
    self.nextKeyFrameIndex = math.random(0, 99) + 120
end

return GameLayer
