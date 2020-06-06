function GenerateQuads(atlas,tileWidth,tileHeight)
    local sheetHeight=atlas:getHeight()/tileHeight
    local sheetWidth=atlas:getWidth()/tileWidth
    local sheetCounter=1
    local spritesheet={}

    for y=0,sheetHeight-1 do
        for x=0,sheetWidth-1 do
            spritesheet[sheetCounter]=love.graphics.newQuad(x*tileWidth,y*tileHeight,tileWidth,tileHeight,atlas:getDimensions())
            sheetCounter=sheetCounter+1
        end
    end
    return spritesheet
end

function table.slice(tbl,start,last,steps)
    local sliced={}
    for i = start or 1, last or #tbl,steps or 1 do
        sliced[i]=tbl[i]
    end
    return sliced
end
function GenerateQuadsPaddle(atlas)
    local x=0
    local y=64
    local quad={}
    local counter=1
    for i =0,3 do
        --smallest paddle
        quad[counter]=love.graphics.newQuad(x,y,32,16,atlas:getDimensions())
        counter=counter+1

        --medium paddle
        quad[counter]=love.graphics.newQuad(x+32,y,64,16,atlas:getDimensions())
        counter=counter+1

        --large paddle
        quad[counter]=love.graphics.newQuad(x+96,y,96,16,atlas:getDimensions())
        counter=counter+1

        --ultralarge paddle
        quad[counter]=love.graphics.newQuad(x,y+16,128,16,atlas:getDimensions())
        counter=counter+1
        x=0
        y=y+32
    end
    return quad
end
function GenerateQuadsBall(atlas)
    local x,y=3*32,3*16
    local counter=1
    local quads={}
    for i=0,3 do
        quads[counter]=love.graphics.newQuad(x,y,8,8,atlas:getDimensions())
        counter=counter+1
        x=x+8
    end
    y=y+8
    x=3*32
    for i=0,2 do
        quads[counter]=love.graphics.newQuad(x,y,8,8,atlas:getDimensions())
        counter=counter+1
        x=x+8
    end
    return quads
end
function GenerateQuadsBrick(atlas)
    local x,y=0,0
    local counter,quads=1,{}
    for i=0,2 do
        --size of bricks is 32X16
        x=0
        for j=0,5 do
            quads[counter]=love.graphics.newQuad(x,y,32,16,atlas:getDimensions())
            counter=counter+1
            x=x+32
        end
        y=y+16
    end
    x=0
    y=48
    for i=0,2 do
        quads[counter]=love.graphics.newQuad(x,y,32,16,atlas:getDimensions())
        counter=counter+1
        x=x+32
    end
    return quads
end
function GenerateQuadsHealth(pic)
    local quads={}
    quads[1]=love.graphics.newQuad(0,0,10,9,pic:getDimensions())
    quads[2]=love.graphics.newQuad(10,0,10,9,pic:getDimensions())
    return quads
end
function GenerateQuadsArrow(pic)
    local quads={}
    quads[1]=love.graphics.newQuad(0,0,24,24,pic:getDimensions())
    quads[2]=love.graphics.newQuad(24,0,24,24,pic:getDimensions())
    return quads
end
function GenerateQuadsPowerUp(pic)
    local x,y=32,16*12
    local quads={}
    for i=1,8 do
        quads[i]=love.graphics.newQuad(x,y,16,16,pic:getDimensions())
        x=x+16
    end
    return quads
end
function GenerateQuadsPowerBrick(pic)
    local quads=love.graphics.newQuad(32*5,16*3,32,16,pic:getDimensions())
    return quads
end