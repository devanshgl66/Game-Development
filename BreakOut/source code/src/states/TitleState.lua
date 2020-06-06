TitleState=Class{__includes=BaseClass}

function TitleState:init()
    self.highlight=1
    self.options={
        [1]='START',
        [2]='HIGH SCORE'
    }
end
function TitleState:update(dt)
    if love.keyboard.wasPressed('escape') then
        love.event.quit()
    elseif love.keyboard.wasPressed('up') or love.keyboard.wasPressed('down') then
        self.highlight=self.highlight==1 and 2 or 1
        gSound['select']:play()
    elseif love.keyboard.wasPressed('return') then
        if self.highlight==1 then
            gStateMachine:change('paddle-select') 
        else
            gStateMachine:change('highscore') 
        end
        gSound['confirm']:play()
    end
end
function TitleState:render()
    love.graphics.setFont(gFont['large'])
    love.graphics.print('BREAKOUT',VIRTUAL_WIDTH/2-4*16,VIRTUAL_HEIGHT/2-32)
    love.graphics.setFont(gFont['medium'])
    for i,j in pairs(self.options) do 
        if i==self.highlight then
            love.graphics.setColor(0,0,132,255) 
        end
        love.graphics.print(j,VIRTUAL_WIDTH/2-(string.len(j)/2)*8,VIRTUAL_HEIGHT*0.75+(i-1)*16)
        love.graphics.setColor(255,255,255,255)
    end
end
