local GameScene = class("GameScene", function()
    return cc.Scene:createWithPhysics()
end)

function GameScene.createScene()
    local scene = GameScene.new()
    scene:getPhysicsWorld():setGravity(cc.p(0, 0))

    local layer = require("GameLayer").new()
    layer:init()
    scene:addChild(layer)

    return scene
end

return GameScene