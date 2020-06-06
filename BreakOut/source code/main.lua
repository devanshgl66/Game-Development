require 'src/dependencies'
quads={}
function love.load()
    push:setupScreen(VIRTUAL_WIDTH,VIRTUAL_HEIGHT,WINDOW_WIDTH,WINDOW_HEIGHT,{
        vsync=true,
        fullscreen=true,
        resizable=true
    })
    love.graphics.setDefaultFilter('nearest','nearest')
    gSound={
        ['paddle-hit'] = love.audio.newSource('sounds/paddle_hit.wav','static'),
        ['score'] = love.audio.newSource('sounds/score.wav','static'),
        ['wall-hit'] = love.audio.newSource('sounds/wall_hit.wav','static'),
        ['confirm'] = love.audio.newSource('sounds/confirm.wav','static'),
        ['select'] = love.audio.newSource('sounds/select.wav','static'),
        ['no-select'] = love.audio.newSource('sounds/no-select.wav','static'),
        ['brick-hit-1'] = love.audio.newSource('sounds/brick-hit-1.wav','static'),
        ['brick-hit-2'] = love.audio.newSource('sounds/brick-hit-2.wav','static'),
        ['hurt'] = love.audio.newSource('sounds/hurt.wav','static'),
        ['victory'] = love.audio.newSource('sounds/victory.wav','static'),
        ['recover'] = love.audio.newSource('sounds/recover.wav','static'),
        ['high-score'] = love.audio.newSource('sounds/high_score.wav','static'),
        ['pause'] = love.audio.newSource('sounds/pause.wav','static'),

        ['music'] = love.audio.newSource('sounds/music.wav','static')
    }
    -- gSound['music']:setLooping(true)
    -- gSound['music']:play()  
    gFont={
        ['small']=love.graphics.newFont('fonts/font.ttf',8),
        ['medium']=love.graphics.newFont('fonts/font.ttf',16),
        ['large']=love.graphics.newFont('fonts/font.ttf',32),
    }
    gTexture={
        ['background']=love.graphics.newImage('graphics/background.png'),
        ['main'] = love.graphics.newImage('graphics/breakout.png'),
        ['arrows'] = love.graphics.newImage('graphics/arrows.png'),
        ['hearts'] = love.graphics.newImage('graphics/hearts.png'),
        ['particle'] = love.graphics.newImage('graphics/particle.png')
    }

    gFrame={
        ['paddle']=GenerateQuadsPaddle(gTexture['main']),
        ['ball']=GenerateQuadsBall(gTexture['main']),
        ['brick']=GenerateQuadsBrick(gTexture['main']),
        ['keybrick']=GenerateQuadsPowerBrick(gTexture['main']),
        ['heart']=GenerateQuadsHealth(gTexture['hearts']),
        ['arrow']=GenerateQuadsArrow(gTexture['arrows']),
        ['power-up']=GenerateQuadsPowerUp(gTexture['main'])
    }

    gStateMachine=StateMachine{
        ['title']=function() return TitleState() end,
        ['highscore']=function() return HighScoreState() end,
        ['paddle-select']=function() return PaddleSelectState() end,
        ['play']=function() return PlayState() end,
        ['serve']=function() return ServeState() end,
        ['victory']=function() return VictoryState() end,
        ['gameover']=function() return GameOverState() end,
        ['enter-high-score']=function() return EnterHighScoreState() end
    }
    --changing game state
    gStateMachine:change('title')
    love.keyboard.keyPressed={}
end
function love.resize(w,h)
    push:resize(w,h)
end
function love.update(dt)
    gStateMachine:update(dt)
    love.keyboard.keyPressed={}
end
function love.keypressed(key)
    love.keyboard.keyPressed[key]=true
end
function love.keyboard.wasPressed(key)
    if love.keyboard.keyPressed[key]==true then
        return true
    else
        return false
    end
end
function love.draw()
    push:apply('start')
    local bgWidth=gTexture['background']:getWidth()
    local bgHeight=gTexture['background']:getHeight()
    love.graphics.draw(gTexture['background'],0,0,0,VIRTUAL_WIDTH/(bgWidth),VIRTUAL_HEIGHT/(bgHeight))
    gStateMachine:render()
    push:apply('end')
end


function renderScore()
    love.graphics.setFont(gFont['medium'])
    love.graphics.printf('SCORE: ' .. tostring(gStateMachine.current.score),10,10,VIRTUAL_WIDTH,'left')
    love.graphics.printf('LEVEL: ' .. tostring(gStateMachine.current.level),10,10,VIRTUAL_WIDTH,'center')
end

function renderHealth()
    for i=1,3 do
        if (i<=gStateMachine.current.health) then
            love.graphics.draw(gTexture['hearts'],gFrame['heart'][1],VIRTUAL_WIDTH-50+10*(i-1),10)
        else
            love.graphics.draw(gTexture['hearts'],gFrame['heart'][2],VIRTUAL_WIDTH-50+10*(i-1),10)
        end
    end
end

function loadHighScore()
    --function to store highscore

    --setting write directory
    love.filesystem.setIdentity('breakout')

    --loading data from file
    if not love.filesystem.getInfo('breakout.txt') then
        --file not found so creating data and storing it in file
        local data=''
        for i=1,10 do
            data=data .. 'CCC\n'
            data=data .. tostring(100*(10-i)) .. '\n'
        end
        love.filesystem.write('breakout.txt',data)
    end
    --reading data from file
    local toggle=false
    local score={}
    local counter=1
    for i=1,10 do
        score[i]={
            name=nil,
            score=nil
        }
    end
    for line in love.filesystem.lines('breakout.txt') do
        if toggle then
            score[counter].score=tonumber(line)
            counter=counter+1
        else
            score[counter].name=string.sub(line,1,3)
            
        end
        toggle=not toggle
    end
    return score
end