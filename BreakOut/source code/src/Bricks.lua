Brick=Class{}
paletteColors = {
    -- blue
    [1] = {
        ['r'] = 99,
        ['g'] = 155,
        ['b'] = 255
    },
    -- green
    [2] = {
        ['r'] = 106,
        ['g'] = 190,
        ['b'] = 47
    },
    -- red
    [3] = {
        ['r'] = 217,
        ['g'] = 87,
        ['b'] = 99
    },
    -- purple
    [4] = {
        ['r'] = 215,
        ['g'] = 123,
        ['b'] = 186
    },
    -- gold
    [5] = {
        ['r'] = 251,
        ['g'] = 242,
        ['b'] = 54
    }
}
function Brick:init(x,y,powerbrick)
    self.x=x
    self.y=y
    self.width=32
    self.height=16
    self.color=1
    self.tier=0
    self.inPlay=true
    --adding particle system
    self.psystem=love.graphics.newParticleSystem(gTexture['particle'],16)
    self.psystem:setParticleLifetime(0.5, 1)
    self.psystem:setLinearAcceleration(-15, 0, 15, 80)
    self.psystem:setEmissionArea('normal', 10, 10)
    --adding power up system
    self.powerkey=false
    --set it as power brick
    self.powerbrick=powerbrick
    --adding a random power
    if math.random(100)%2==0 then
        self.powerup=Power(math.random(7),self.x,self.y)
    else
        self.powerup=false
    end
end
function Brick:update(dt)
    if self.powerup then
        self.powerup:update(dt)
    end
    self.psystem:update(dt)

end
function Brick:hit()
    self.psystem:setColors(
        paletteColors[self.color].r,
        paletteColors[self.color].g,
        paletteColors[self.color].b,
        55 * (self.tier + 1),
        paletteColors[self.color].r,
        paletteColors[self.color].g,
        paletteColors[self.color].b,
        0
    )
    self.psystem:emit(64)
    if self.powerbrick then
        if self.powerkey then
            self.inPlay=false
            gSound['brick-hit-2']:play()
        end
        return
    end
    if self.tier>0 then
        if self.color==1 then
            self.color=5
            self.tier=self.tier-1
        else
            self.color=self.color-1
        end
        gSound['brick-hit-1']:play()
    else
        if self.color>1 then
            self.color=self.color-1
            gSound['brick-hit-1']:play()
        else
            self.inPlay=false
            gSound['brick-hit-2']:play()
            if (self.powerup==false)==false then
                self.powerup.inPlay=true
            end
        end
    end
end
function Brick:render()
    if self.inPlay==true then
        if self.powerbrick then
            love.graphics.draw(gTexture['main'],gFrame['keybrick'],self.x,self.y)
        else
            love.graphics.draw(gTexture['main'],gFrame['brick'][self.tier+(self.color-1)*4+1],self.x,self.y)
        end
    else
        if self.powerup then
            self.powerup:render()
        end
    end
    -- love.graphics.draw(gTexture['main'],gFrame['brick'][1],self.x,self.y)
end
function Brick:renderParticles()
    love.graphics.draw(self.psystem, self.x + 16, self.y + 8)
end