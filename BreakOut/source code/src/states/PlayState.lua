PlayState=Class{__includes=BaseClass}
function PlayState:init()
    self.paused=false
end
function PlayState:enter(params)
    self.paddle=params.paddle
    self.ball=params.ball
    self.bricks=params.bricks
    self.score=params.score
    self.level=params.level
    self.health=params.health
    self.paddleSkin=params.paddleSkin
    self.ball[1].dy=-100
    self.ball[1].dx=100
end
function PlayState:update(dt)
    if love.keyboard.wasPressed('space') then
        self.paused=not self.paused
        gSound['pause']:play()
    elseif love.keyboard.wasPressed('escape') then
        love.event.quit()
    end
    if not self.paused then
        self.paddle:update(dt)
        for i,ball in pairs(self.ball) do
            ball:update(dt)
        end
    end

    --checking for ball out
    for i,ball in pairs(self.ball) do
        if ball.y>=VIRTUAL_HEIGHT then
            table.remove(self.ball,i)
        end
    end


    if #self.ball<=0 then
        gSound['hurt']:play()
        if self.health>0 then
            self.health=self.health-1
            gStateMachine:change('serve',{
                score=self.score,
                health=self.health,
                level=self.level,
                bricks=self.bricks,
                paddleSkin=self.paddleSkin
            })
        end
    end

    --GAME OVER IF HEALTH=0
    if self.health==0 then
        gStateMachine:change('gameover',{
            score=self.score
        })
    end
        


    --checking ball collision with paddle

    for i,ball in pairs(self.ball) do
        if ball:collide(self.paddle) then 
            ball.y=self.paddle.y-ball.height
            ball.dy=-ball.dy
            --changing ball velocity in x,y direction
            if self.paddle.x+self.paddle.width/2>ball.x+ball.width/2 then
                --ball is in left side of paddle
                ball.dx=-(self.paddle.x+self.paddle.width/2-ball.x+ball.width/2)*10
            else
                ball.dx=-(self.paddle.x+self.paddle.width/2-ball.x+ball.width/2)*10
            end
            gSound['paddle-hit']:play()
        end
    end

    --checking ball collision with bricks

    for i,ball in pairs(self.ball) do
        for i,brick in pairs(self.bricks) do
            brick:update(dt)
            if brick.inPlay and ball:collide(brick) then
                
                --updating score if brick is not power brick
                if brick.powerbrick ==false then
                    self.score=self.score+1
                end
                --ON BRICK COLLISION SETTING BALL POSITION
                if ball.x + 2 < brick.x and ball.dx > 0 then
                    ball.dx = -ball.dx
                    ball.x = brick.x - 8
                
                elseif ball.x + 6 > brick.x + brick.width and ball.dx < 0 then
                    
                    ball.dx = -ball.dx
                    ball.x = brick.x + 32
                
                elseif ball.y < brick.y then
                    
                    ball.dy = -ball.dy
                    ball.y = brick.y - 8
                
                else
                    
                    ball.dy = -ball.dy
                    ball.y = brick.y + 16
                end

                brick:hit()
            end
        end
    end

    if self:checkVictory() then
        gStateMachine:change('victory',{
            level=self.level,
            score=self.score,
            health=self.health,
            paddleSkin=self.paddleSkin
        })
        gSound['victory']:play()
    end

    --checking for power up collision with paddle
    for i,brick in pairs(self.bricks) do
        if brick.powerup then
            if brick.powerup.inPlay and brick.powerup:collide(self.paddle) then
                brick.powerup.inPlay=false
                self:ActivePowerup(brick.powerup.power_no)
            end
        end
    end
end
function PlayState:render()
    --showing pause message if paused
    if self.paused then
        love.graphics.setFont(gFont['large'])
        love.graphics.print("PAUSED",VIRTUAL_WIDTH/2-3*16,VIRTUAL_HEIGHT/2-16)
    else
        self.paddle:render()

        for i,ball in pairs(self.ball) do
            ball:render()
        end
        --rendering all bricks
        for i,brick in pairs(self.bricks) do
            brick:render()
        end
        -- render all particle systems
        for k, brick in pairs(self.bricks) do
            brick:renderParticles()
        end
        renderScore()
        renderHealth()
    end

end

function PlayState:checkVictory()
    for i,brick in pairs(self.bricks) do
        if brick.inPlay then
            return false
        end
    end
    return true
end
function PlayState:ActivePowerup(no)
    if no==1 then
        if self.health<3 then
            self.health=self.health+1
        end
    elseif no==2 then
        for i,ball in pairs(self.ball) do
            table.remove(self.ball,i)
        end
    elseif no==3 then
        if self.paddle.size<5 then
            self.paddle.size=self.paddle.size+1
        end
    elseif no==4 then
        if self.paddle.size>2 then
            self.paddle.size=self.paddle.size-1
        end
    elseif no==5 then

        for i,ball in pairs(self.ball) do
            if ball.width>8 then
                ball.width=ball.width/2
                ball.height=ball.height/2
            end
        end
    elseif no==6 then

        for i,ball in pairs(self.ball) do
            if ball.width<16 then
                ball.width=ball.width*2
                ball.height=ball.height*2
            end
        end
    elseif no==7 then    
        local ball= Ball(math.random(7))
        ball.dy=-math.random(50,100)
        ball.dx=100
        ball.width=self.ball[1].width
        ball.height=self.ball[1].height
        table.insert(self.ball,ball)

    elseif no==8 then
        for i,brick in pairs(self.bricks) do
            brick.powerkey=true
        end
    end
end