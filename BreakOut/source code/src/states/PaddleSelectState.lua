PaddleSelectState=Class{__includes=BaseClass}

function PaddleSelectState:init()
    self.paddleNumber=4
    self.arrow=1
    self.larrowSize=1
    self.rarrowSize=1
    self.timer=0
end
function PaddleSelectState:update(dt)
    --enlarge the arrow on arrow key
    self.timer=self.timer+dt
    if self.timer>0.2 then
        self.larrowSize=1
        self.rarrowSize=1
        self.timer=0
    end
    if love.keyboard.wasPressed('left') then
        self.paddleNumber=(self.paddleNumber-1)%5
        self.larrowSize=1.3
        if self.paddleNumber==0 then
            self.paddleNumber=4
        end
    elseif love.keyboard.wasPressed('right') then
        self.paddleNumber=(self.paddleNumber+1)%5
        self.rarrowSize=1.3
        if self.paddleNumber==0 then
            self.paddleNumber=1
        end
    elseif love.keyboard.wasPressed('escape') then
        gStateMachine:change('title')
    elseif love.keyboard.wasPressed('return') then
        gStateMachine:change('serve',{
            level=1,
            score=0,
            health=3,
            paddleSkin=self.paddleNumber
        })
    end
end
function PaddleSelectState:render()
    love.graphics.setFont(gFont['large'])
    love.graphics.printf('Select Paddle',0,VIRTUAL_HEIGHT/3,VIRTUAL_WIDTH,'center')
    love.graphics.draw(gTexture['main'],gFrame['paddle'][2+4*(self.paddleNumber-1)],VIRTUAL_WIDTH/2-32,VIRTUAL_HEIGHT*0.66)
    love.graphics.draw(gTexture['arrows'],gFrame['arrow'][1],VIRTUAL_WIDTH/3,VIRTUAL_HEIGHT*0.66-5,0,self.larrowSize,self.larrowSize)
    love.graphics.draw(gTexture['arrows'],gFrame['arrow'][2],VIRTUAL_WIDTH*0.60+5,VIRTUAL_HEIGHT*0.66-5,0,self.rarrowSize,self.rarrowSize)
end