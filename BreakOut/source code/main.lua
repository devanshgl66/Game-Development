require 'src/dependencies'
function love.load()
    push:setupScreen(VIRTUAL_WIDTH,VIRTUAL_HEIGHT,WINDOW_WIDTH,WINDOW_HEIGHT,{
        vsync=true,
        fullscreen=false,
        resizable=true
    })
    gTexture={
        ['background']=love.graphics.newImage('graphics/background.png')
    }
end
function love.resize(w,h)
    push:resize(w,h)
end
function love.update(dt)

end
function love.draw()
    push:apply('start')
    -- local bgWidth=gTexture['background']:getWidth()
    -- local bgHeight=gTexture['background']:getHeight()
    -- love.graphics.draw(gTexture['background'],0,0,0,VIRTUAL_WIDTH/(bgWidth),VIRTUAL_HEIGHT/(bgHeight))
    
    local backgroundWidth = gTexture['background']:getWidth()
    local backgroundHeight = gTexture['background']:getHeight()

    love.graphics.draw(gTexture['background'], 
    -- draw at coordinates 0, 0
    0, 0, 
    -- no rotation
    0,
    -- scale factors on X and Y axis so it fills the screen
    VIRTUAL_WIDTH / (backgroundWidth - 1), VIRTUAL_HEIGHT / (backgroundHeight - 1))

    push:apply('end')
end