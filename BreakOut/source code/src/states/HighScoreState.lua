HighScoreState=Class{__includes=BaseClass}

function HighScoreState:init()
    self.highScores=loadHighScore()
end

function HighScoreState:update(dt)
    -- return to the start screen if we press escape
    if love.keyboard.wasPressed('escape') then
        gSound['wall-hit']:play()
        
        gStateMachine:change('title' )
    end
end

function HighScoreState:render()
    love.graphics.setFont(gFont['large'])
    love.graphics.printf('High Scores', 0, 20, VIRTUAL_WIDTH, 'center')

    love.graphics.setFont(gFont['medium'])

    -- iterate over all high score indices in our high scores table
    for i = 1, 10 do
        local name = self.highScores[i].name or '---'
        local score = self.highScores[i].score or '---'

        -- score number (1-10)
        love.graphics.printf(tostring(i) .. '.', VIRTUAL_WIDTH / 4, 
            60 + i * 13, 50, 'left')

        -- score name
        love.graphics.printf(name, VIRTUAL_WIDTH / 4 + 38, 
            60 + i * 13, 50, 'right')
        
        -- score itself
        love.graphics.printf(tostring(score), VIRTUAL_WIDTH / 2,
            60 + i * 13, 100, 'right')
    end
    love.graphics.print(tostring(self.highScores[3].name),50,50)
    love.graphics.setFont(gFont['small'])
    love.graphics.printf("Press Escape to return to the main menu!",
        0, VIRTUAL_HEIGHT - 18, VIRTUAL_WIDTH, 'center')
end