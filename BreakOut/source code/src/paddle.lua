Paddle=Class{}
function Paddle:init(skin)
    self.x=VIRTUAL_WIDTH/2-32
    self.y=VIRTUAL_HEIGHT-32

    self.dx=0
    self.skin=skin
    self.size=2
    self.width=self.size*32
    self.height=16
end
function Paddle:update(dt)
    self.width=self.size*32
    if love.keyboard.wasPressed('escape') then
        love.event.quit()
    end
    if love.keyboard.isDown('left') then
        self.dx=-PADDLE_SPEED*dt
    elseif love.keyboard.isDown('right') then
        self.dx=PADDLE_SPEED*dt
    else
        self.dx=0
    end
    self.x=self.x+self.dx
    if self.x<0 then
        self.x=0
    elseif self.x+self.width>VIRTUAL_WIDTH then
        self.x=VIRTUAL_WIDTH-self.width
    end
end

function Paddle:render()
    love.graphics.draw(gTexture['main'],gFrame['paddle'][self.size+4*(self.skin-1)],self.x,self.y)
end