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
    if(self.score<=50) then
        love.graphics.draw(self.bronze,VIRTUAL_WIDTH/5*4-self.gold:getWidth()/2,VIRTUAL_HEIGHT/3)
    elseif self.score<=75 then
        love.graphics.draw(self.silver,VIRTUAL_WIDTH/5*4-self.gold:getWidth()/2,VIRTUAL_HEIGHT/3)
    else
        love.graphics.draw(self.gold,VIRTUAL_WIDTH/5*4-self.gold:getWidth()/2,VIRTUAL_HEIGHT/3)
    end

    love.graphics.setFont(flappyFont)
    love.graphics.printf('Oops! You lost!', 0, VIRTUAL_HEIGHT/10, VIRTUAL_WIDTH, 'center')
    love.graphics.setFont(mediumFont)
    love.graphics.printf('Score: ' .. tostring(self.score), 0, VIRTUAL_HEIGHT/10+150, VIRTUAL_WIDTH, 'center')

    love.graphics.printf('Press X to Play Again!', 0, VIRTUAL_HEIGHT/10+300, VIRTUAL_WIDTH, 'center')

end
function ScoreState:exit()
    
end