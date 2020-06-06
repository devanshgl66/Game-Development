Power=Class{}
function Power:init(pno,x,y)
    self.power_no=pno
    self.x=x
    self.y=y
    self.dy=50
    self.inPlay=false
    self.width=16
    self.height=16
end
function Power:update(dt)
    if self.inPlay then
        --updating power-up position
        self.y=self.y+self.dy*dt
    end
end
function Power:collide(ob)
    --doing AABB collision testing
    --if left edge of ball>right edge of ob or vice versa then no collision
    if self.x>ob.x+ob.width or ob.x>self.x+self.width then
        return false
    --doing the same but on top and bottom edges
    elseif self.y>ob.y+ob.height or ob.y>self.y+self.height then
        return false
    end
    --if above is not true then collision happened
    return true
end

function Power:render()
    if self.inPlay then
        love.graphics.draw(gTexture['main'],gFrame['power-up'][self.power_no],self.x,self.y)
    end
end