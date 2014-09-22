local Item = class("Item", function()
    return cc.Sprite:create()
end)

function Item:init(type)
    if type < 25 then
    	print("Good")
    else
        print("Bad")
    end

	local width = 30--math.random(0, 24) + 5
    local height = 30--math.random(0, 29) + 10
	
	self:setPositionX(cc.Director:getInstance():getVisibleSize().width)
	
    self:setContentSize(width,height)
    self:setTextureRect(cc.rect(0, 0, width, height))
	self:setColor(cc.c3b(0, 0, 0))
	
    self:setPhysicsBody(cc.PhysicsBody:createBox(cc.size(width, height)))
	
    function update()
		self:setPositionY(self:getPositionY() - 5)
		
		if (self:getPositionY() < 0) then
		    self:unscheduleUpdate()
		    self:removeFromParent()
		end
	end
	
	self:scheduleUpdateWithPriorityLua(update, 5)
end

return Item