StateMachine = Class{}

function StateMachine:init(states)
    --initial state
    self.empty={
        update=function() end,
        render=function() end,
        exit=function() end,
        enter=function() end
    }
    self.current=self.empty
    self.states=states or {}
end
function StateMachine:change(newState,newParams)
    assert(self.states[newState])    --new state should be present in state machine
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