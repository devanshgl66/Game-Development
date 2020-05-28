WINDOW_HEIGHT=720
WINDOW_WIDTH=1280

VIRTUAL_WIDTH=512
VIRTUAL_HEIGHT=288


background=love.graphics.newImage('background.png')
backgroundScroll=0
BACKGROUND_SCROLL_SPEED=30
BACKGROUND_LOOPING_POINT=412

ground=love.graphics.newImage('ground.png')
groundScroll=0
GROUND_SCROLL_SPEED=60


push=require 'push'
Class=require 'class'
require 'Bird'
require 'Pipe'
require 'PipePair'
require 'StateMachine'
require 'states/PlayState'
require 'states/TitleState'
require 'states/ScoreState'
require 'states/CountDownState'
--global variable
scrolling=true

function love.load()
    love.window.setTitle('Flappy Bird')
    love.graphics.setDefaultFilter('nearest','nearest')
    push:setupScreen(VIRTUAL_WIDTH,VIRTUAL_HEIGHT,WINDOW_WIDTH,WINDOW_HEIGHT,{
        vsync=true,
        fullscreen=true,
        resizable=true
    })
    math.randomseed(os.time())

    --loading different font in different size
    smallFont = love.graphics.newFont('font.ttf', 8)
    mediumFont = love.graphics.newFont('flappy.ttf', 14)
    flappyFont = love.graphics.newFont('flappy.ttf', 28)
    hugeFont = love.graphics.newFont('flappy.ttf', 56)
    love.graphics.setFont(flappyFont)

    sound={
        ['jump'] = love.audio.newSource('jump.wav', 'static'),
        ['explosion'] = love.audio.newSource('explosion.wav', 'static'),
        ['hurt'] = love.audio.newSource('hurt.wav', 'static'),
        ['score'] = love.audio.newSource('score.wav', 'static'),
        ['pause'] = love.audio.newSource('pause.wav', 'static'),
        ['music'] = love.audio.newSource('marios_way.mp3', 'static')
    }

    gStateMachine=StateMachine{
        ['play']=function() return PlayState() end,
        ['title']=function() return TitleState() end,
        ['score']=function() return ScoreState() end,
        ['countdown']=function() return CountDownState() end
    }
    -- gStateMachine.current=gStateMachine.states.play
    gStateMachine:change('title')
    love.keyboard.keysPressed={}

    --background music
    sound['music']:setLooping(true)
    sound['music']:play()
end

function love.resize(w,h)
    push:resize(w,h)
end
x=true
function love.keypressed(key)
    if key == 'escape' then
        love.event.quit()
    
    elseif key == 'return' then
        gamepause=false 
    else
        love.keyboard.keysPressed[key]=true
    end
end

function love.keyboard.wasPressed(key)
    if love.keyboard.keysPressed[key] then
        return true
    else 
        return false
    end
end

function love.update(dt)
    if scrolling then
        backgroundScroll=(backgroundScroll+BACKGROUND_SCROLL_SPEED*dt)%BACKGROUND_LOOPING_POINT
        groundScroll=(groundScroll+GROUND_SCROLL_SPEED*dt)%VIRTUAL_WIDTH
    end
    gStateMachine:update(dt)
    love.keyboard.keysPressed={}
end


function love.draw()
    push:start()
    love.graphics.draw(background,-backgroundScroll,0)
    
    gStateMachine:render()
    love.graphics.draw(ground,-groundScroll,VIRTUAL_HEIGHT-16)
    push:finish()
end