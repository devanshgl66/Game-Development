Pipe=Class{}

local PIPE_IMAGE=love.graphics.newImage('pipe.png')

function Pipe:init(orientation, y)
    self.y=y
    self.orientation=orientation
    self.width=PIPE_IMAGE:getWidth()
    self.x=VIRTUAL_WIDTH-50
    self.dx=60
    self.remove=false
end
function Pipe:update(dt)
end
function Pipe:render()
    if self.orientation=='top' then

        -- love.graphics.rectangle('fill',self.x,0,self.width,self.y+1)
        love.graphics.draw(PIPE_IMAGE,self.x,self.y,
        0,  --rotation 
        1,  --X Scale
        -1) --Y Scale

    else

        -- love.graphics.rectangle('fill',self.x,VIRTUAL_HEIGHT-self.y-16,self.width,self.y)
        love.graphics.draw(PIPE_IMAGE,self.x,self.y,0,1,1)
    end
    -- love.graphics.printf(tostring(self.x),20,20,150,'center')

    -- love.graphics.draw(PIPE_IMAGE,self.x,self.y,0,0.75,1)
end