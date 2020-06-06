StateMachine=Class{__includes == BaseState}

function StateMachine:init(states)
    self.empty={
        enter=function(params) end,
        exit=function() end,
        update=function(dt) end,
        render=function() end,
    }
    self.current=self.empty
    self.states=states or {}
end
function StateMachine:change(newState,newParams)
    assert(self.states[newState])
    self.current:exit()
    
    self.current=self.states[newState]()
    self.current:enter(newParams)
end
function StateMachine:update(dt)
    
    self.current:update(dt)
end
function StateMachine:render()
    self.current:render()
end