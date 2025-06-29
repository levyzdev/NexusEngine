local camEase = 3
local beatZoom = 0.015 
local XDShake = 0

local baseZoom = 1   
local zoomNow = baseZoom

local chillCamX, chillCamY = 0, 0

function onCreate()
    setProperty('camGame.zoom', baseZoom)
end

function onUpdate(elapsed)
    local aimX = getProperty('camFollow.x')
    local aimY = getProperty('camFollow.y')

    chillCamX = chillCamX + (aimX - chillCamX) * camEase
    chillCamY = chillCamY + (aimY - chillCamY) * camEase

    local wiggleX = math.sin(os.clock() * 1.5) * XDShake
    local wiggleY = math.cos(os.clock() * 1.5) * XDShake

    setProperty('camFollowPos.x', chillCamX + wiggleX)
    setProperty('camFollowPos.y', chillCamY + wiggleY)

    local actualZoom = getProperty('camGame.zoom')
    setProperty('camGame.zoom', actualZoom + (zoomNow - actualZoom) * 0.05)
end

function onBeatHit()
    zoomNow = baseZoom + beatZoom
end

function onStepHit()
    if curStep % 4 == 0 then
        zoomNow = baseZoom
    end
end
