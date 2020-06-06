VictoryState=Class{__includes=BaseClass}
function VictoryState:enter(param)
    self.score=param.score
    self.level=param.level
    self.health=param.health
    self.paddleSkin=param.paddleSkin
end
function VictoryState:update(dt)
    if love.keyboard.wasPressed('return') then
        gStateMachine:change('serve',{
            level=self.level+1,
            score=self.score,
            health=self.health,
            paddleSkin=self.paddleSkin
        })
    end
end
function VictoryState:render()
    love.graphics.printf("Level Cleared",0,VIRTUAL_HEIGHT/2-50,VIRTUAL_WIDTH,'center')
end