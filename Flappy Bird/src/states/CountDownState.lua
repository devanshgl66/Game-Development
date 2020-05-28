CountDownState=Class{}

TIME=0.75
function CountDownState:init()
    self.counter=3
    self.timer=0
end
function CountDownState:update(dt)
    self.timer=self.timer+dt
    if self.timer>=TIME then
        self.counter=self.counter-1
        self.timer=0
    end
    if self.counter<=0 then
        gStateMachine:change('play')
    end
end
function CountDownState:render()
    love.graphics.setFont(hugeFont)
    love.graphics.printf(tostring(self.counter), 0, 120, VIRTUAL_WIDTH, 'center')
end
function CountDownState:enter()

end
function CountDownState:exit()

end