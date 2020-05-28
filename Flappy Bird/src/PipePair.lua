PipePair=Class{}

local GAP_HEIGHT=90
function PipePair:init(y)
    self.x=VIRTUAL_WIDTH
    self.y=y
    self.scored=false
    self.pipes={
        ['top']=Pipe('top',self.y),
        ['bottom']=Pipe('bottom',self.y+GAP_HEIGHT)
    }
    self.width=self.pipes.top.width
end
function PipePair:update(dt)
    GAP_HEIGHT=math.random(65,90)
    if self.x<-PIPE_WIDTH-32 then
        self.pipes['top'].remove=true
        self.pipes['bottom'].remove=true
    else
        self.x=self.x-PIPE_SPEED*dt
        self.pipes.top.x=self.x
        self.pipes.bottom.x=self.x
    end
end
function PipePair:render()
    -- for l,pipe in pairs(self.pipes) do
    --     pipe:render()
    -- end

    
    self.pipes.top:render()
    self.pipes.bottom:render()
end