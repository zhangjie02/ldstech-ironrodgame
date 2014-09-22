local MenuLayer = class("MenuLayer", function()
    return cc.LayerColor:create(cc.c4b(255,255,255,255))
end)

function MenuLayer:init()
    local visibleSize = cc.Director:getInstance():getVisibleSize()

    local bg = cc.Sprite:create("clouds.jpg")
    bg:setPosition(visibleSize.width / 2, visibleSize.height / 2)
    self:addChild(bg)

    -- add title
    local title = cc.Sprite:create("title.png")
    self:addChild(title)
    title:setPosition(visibleSize.width / 2, visibleSize.height / 2 + 120)
    
    local function menuCallbackStart()
        cc.Director:getInstance():replaceScene(require("GameScene").createScene())
    end

    local start = cc.MenuItemImage:create("start.png", "start.png")
    start:registerScriptTapHandler(menuCallbackStart)
    
    local menu = cc.Menu:create(start)
    self:addChild(menu)
    
    menu:setPosition(visibleSize.width / 2, visibleSize.height / 2)
    
    return true
end

return MenuLayer