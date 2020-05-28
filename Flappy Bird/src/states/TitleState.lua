TitleState=Class{}
function TitleState:init()
    --nothing to do
end
function TitleState:exit()

end
function TitleState:enter()

end
function TitleState:update(dt)
    if love.keyboard.wasPressed('x') then
        gStateMachine:change('countdown')
    end
end
function TitleState:render()
    love.graphics.setFont(flappyFont)
    love.graphics.printf('Fifty Bird', 0, 64, VIRTUAL_WIDTH, 'center')

    love.graphics.setFont(mediumFont)
    love.graphics.printf('Press X', 0, 100, VIRTUAL_WIDTH, 'center')
end