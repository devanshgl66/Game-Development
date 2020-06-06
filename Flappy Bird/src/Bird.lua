Bird=Class{}

local GRAVITY=30
function Bird:init()
    self.image=love.graphics.newImage('bird.png')
    self.width=self.image:getWidth()*1.5
    self.height=self.image:getHeight()*1.5
    self.x=VIRTUAL_WIDTH/2-self.width/2
    self.y=VIRTUAL_HEIGHT/2-self.height/2
    self.dy=0
end
function Bird:collide(pipe)
    
    if self.x+self.width>=pipe.x and self.x<pipe.width+pipe.x then
        if pipe.orientation=='top' then
            if pipe.y>=(self.y) then
                sound['explosion']:play()
                sound['hurt']:play()
                return true
            end
        else
            if pipe.y<(self.y)+(self.width)-16 then -- -16 is ground height
                sound['explosion']:play()
                sound['hurt']:play()
                return true
            end 
        end
    end
    return false
end
function Bird:update(dt)
    self.dy = self.dy + GRAVITY * dt
    self.y=self.y+self.dy
    if love.keyboard.wasPressed('x') or love.keyboard.wasPressed('space')  then
        self.dy=-GRAVITY/4
        sound['jump']:play()
    end

    -- if love.keyboard.wasPressed('w') then
    --     self.y=self.y-5
    --     sound['jump']:play()
    -- elseif love.keyboard.wasPressed('s') then
    --     self.y=self.y+5
    --     sound['jump']:play()
    -- end
end
function Bird:render()
    if self.dy<6 then
        love.graphics.draw(self.image,self.x,self.y,-0.5,1.5,1.5)
    else
        love.graphics.draw(self.image,self.x,self.y,0.5,1.5,1.5)
    end
    -- love.graphics.draw(self.image,self.x,self.y,0,1.5,1.5)
end

