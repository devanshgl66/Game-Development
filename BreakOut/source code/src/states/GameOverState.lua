GameOverState=Class{__includes=BaseClass}

function GameOverState:enter(param)
    self.score=param.score
    self.highscore=loadHighScore()
    self.newHScore=false
    self.scoreIndex=0
end
function GameOverState:update(dt)
    if love.keyboard.wasPressed('return') then
        if self.newHScore==true then
            gStateMachine:change('enter-high-score',{
                score=self.score,
                highScores=self.highscore,
                scoreIndex=self.scoreIndex
            })
        else
            gStateMachine:change('title')
        end
    elseif love.keyboard.wasPressed('escape') then
        love.event.quit()
    end
    for i=1,10 do
        if self.highscore[i].score<self.score then
            self.newHScore=true
            self.scoreIndex=i
            break
        end
    end
end
function GameOverState:render()
    love.graphics.setFont(gFont['large'])
    if self.newHScore then
        love.graphics.printf('NEW HIGH SCORE', 0, VIRTUAL_HEIGHT*0.20, VIRTUAL_WIDTH, 'center')
    end
    love.graphics.printf('GAME OVER', 0, VIRTUAL_HEIGHT / 3, VIRTUAL_WIDTH, 'center')
    love.graphics.setFont(gFont['medium'])
    love.graphics.printf('Final Score: ' .. tostring(self.score), 0, VIRTUAL_HEIGHT / 2,VIRTUAL_WIDTH, 'center')
    love.graphics.printf('Press Enter!', 0, VIRTUAL_HEIGHT - VIRTUAL_HEIGHT / 4,VIRTUAL_WIDTH, 'center')
end