ScoreState=Class{}

function ScoreState:init()
    self.gold=love.graphics.newImage('gold.png')
    self.silver=love.graphics.newImage('silver.png')
    self.bronze=love.graphics.newImage('bronze.png')
end
function ScoreState:enter(params)
    self.score=params.score
end
function ScoreState:update(dt)
    if love.keyboard.wasPressed('x') then
        gStateMachine:change('title')
    end
end
function ScoreState:render()
    -- simply render the score to the middle of the screen
    if(self.score<=10) then
        love.graphics.draw(self.bronze,VIRTUAL_WIDTH/2-self.gold:getWidth()/2,75)
    elseif self.score<=25 then
        love.graphics.draw(self.silver,VIRTUAL_WIDTH/2-self.gold:getWidth()/2,75)
    else
        love.graphics.draw(self.gold,VIRTUAL_WIDTH/2-self.gold:getWidth()/2,75)
    end

    love.graphics.setFont(flappyFont)
    love.graphics.printf('Oops! You lost!', 0, 64, VIRTUAL_WIDTH, 'center')
    love.graphics.setFont(mediumFont)
    love.graphics.printf('Score: ' .. tostring(self.score), 0, 100, VIRTUAL_WIDTH, 'center')

    love.graphics.printf('Press X to Play Again!', 0, 160, VIRTUAL_WIDTH, 'center')

end
function ScoreState:exit()
    
end