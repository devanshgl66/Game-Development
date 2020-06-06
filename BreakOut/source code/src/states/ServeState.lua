ServeState=Class{__includes=BaseClass}

function ServeState:init()
    self.paused=false
    self.ball={Ball(math.random(7))}
end
function ServeState:enter(param)
    self.score=param.score
    self.level=param.level
    self.health=param.health
    if param.bricks then
        self.bricks=param.bricks
    else
        self.bricks=LevelMaker.createMap(self.level)
        --adding key power up
        for b,brick in pairs(self.bricks) do
            if brick.powerup==false then
                brick.powerup=Power(8,brick.x,brick.y)
                break
            end
        end
        --replacing a random brick to keybrick
        self.bricks[math.random(#self.bricks-1)].powerbrick=true
    end
    self.paddleSkin=param.paddleSkin
    self.paddle=Paddle(self.paddleSkin)
end
function ServeState:update(dt)
    if love.keyboard.wasPressed('return') then
        gStateMachine:change('play',{
            paddle=self.paddle,
            ball=self.ball,
            bricks=self.bricks,
            score=self.score,
            level=self.level,
            health=self.health,
            paddleSkin=self.paddleSkin
        })
    elseif love.keyboard.wasPressed('space') then
        self.paused=not self.paused
        gSound['pause']:play()
    end
    self.paddle:update(dt)
    self.ball[1].x=self.paddle.x+self.paddle.width/2-self.ball[1].width/2
    self.ball[1].y=self.paddle.y-self.ball[1].height
end
function ServeState:render()
    if self.paused then
        love.graphics.setFont(gFont['large'])
        love.graphics.print("PAUSED",VIRTUAL_WIDTH/2-3*16,VIRTUAL_HEIGHT/2-16)
    else
        self.paddle:render()
        self.ball[1]:render()
        --rendering all bricks
        for i,brick in pairs(self.bricks) do
            brick:render()
        end
    end
    renderScore()
    renderHealth()
end
