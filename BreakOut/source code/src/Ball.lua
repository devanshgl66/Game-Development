Ball=Class{}
function Ball:init(skin)
    self.width=8
    self.height=8
    self.skin=skin
    self.dy=0
    self.dx=0
    self.x=VIRTUAL_WIDTH/3
    self.y=VIRTUAL_HEIGHT/3*2
end
function Ball:update(dt)
    self.y=self.y+self.dy*dt
    self.x=self.x+self.dx*dt
    --bouncing ball over walls
    if self.x<=0 then 
        self.x=0
        gSound['wall-hit']:play()
        self.dx=-self.dx
    elseif self.x>=VIRTUAL_WIDTH-self.width then
        self.x=VIRTUAL_WIDTH-self.width
        gSound['wall-hit']:play()
        self.dx=-self.dx
    elseif self.y<=0 then
        self.y=0
        gSound['wall-hit']:play()
        self.dy=-self.dy
    -- elseif self.y>VIRTUAL_HEIGHT then
    --     self.y=0
    end
end
--function to reset ball
function Ball:reset()
    self.dx=0
    self.dy=0
    self.x=VIRTUAL_WIDTH/3
    self.y=VIRTUAL_HEIGHT/3*2
end
--function to detect collision between ball and object ob
function Ball:collide(ob)
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
function Ball:render()
    local ballwidth=8
    local ballheight=8
    love.graphics.draw(gTexture['main'],gFrame['ball'][self.skin],self.x,self.y,0,self.width/ballwidth,self.height/ballheight)
end