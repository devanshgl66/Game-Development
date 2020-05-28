PlayState=Class{}

--constants
PIPE_SPEED=60
PIPE_HEIGHT=288
PIPE_WIDTH=70


function PlayState:init()
    self.bird=Bird()
    self.pipePair={}
    self.lastY = 20
    self.score=0
    self.timer=0
    self.spawntimer=2
    self.pause=false
end
function PlayState:update(dt)
    --pausing the game if p is pressed
    if love.keyboard.wasPressed('p') then
        self.pause=not self.pause
        sound['pause']:play() 
    end
    if self.pause==true then
        sound['music']:pause()
        scrolling=false
    else       
        
        sound['music']:play()
        scrolling=true
        self.bird:update(dt)
        self.spawntimer=math.random(150,400)/100
        self.timer=self.timer+dt
        if self.timer>self.spawntimer then
            self.timer=0
            local y = math.max( 30, math.min(self.lastY + math.random(-20, 20), VIRTUAL_HEIGHT - 30))
            self.lastY = y
            table.insert(self.pipePair,PipePair(y))
        end

        --handling extreme conditions
        if self.bird.y<0 then
            self.bird.y=0
            self.bird.dy=0
        elseif self.bird.y>VIRTUAL_HEIGHT+2 then
            self.bird.y=VIRTUAL_HEIGHT+2
            sound['explosion']:play()
            sound['hurt']:play()
            gStateMachine:change('score',{score=self.score})
        end
        --updating all pipes
        for l,pipes in pairs(self.pipePair) do
            pipes:update(dt)
        end

        --removing non existing pipes pair
        for k, pair in pairs(self.pipePair) do
            if pair.remove then
                table.remove(self.pipePair, k)
            end
        end

        --checking for collision
        for l,pipes in pairs(self.pipePair) do 
            for k,pipe in pairs(pipes.pipes) do
                if pipe then
                    if self.bird:collide(pipe) then
                        gStateMachine:change('score',{
                            score=self.score
                        })
                    end
                end
            end
        end

        --incrementing score
        for k,pair in pairs(self.pipePair) do
            if not pair.scored then
                if pair.x+pair.width<self.bird.x then
                    pair.scored=true
                    self.score=self.score+1
                    sound['score']:play()
                end
            end
        end
    end    
end
function PlayState:enter()
    scrolling=true
end
function PlayState:exit()
    scrolling=false
end
function PlayState:render()
    if self.pause==false then
        for l,pipes in pairs(self.pipePair) do
            pipes:render()
        end
        self.bird:render()
        love.graphics.setFont(flappyFont)
        love.graphics.print(tostring(self.score),10,10)
    else
        love.graphics.printf('PAUSE', 0, 120, VIRTUAL_WIDTH, 'center')
    end
end