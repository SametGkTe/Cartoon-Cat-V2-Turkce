local mechanicActive = false
local preSteps = 1

local xPositions = {1100, 900, 650, 300, 140, 50}
local yPositions = {190, 250, 350, 500}

function onCreatePost() -- hecho por lio, mejorado y randomizado por zJosiz :skull:
    makeLuaSprite('dangerImage', 'cc/forest/circle', 0, 0)
    addLuaSprite('dangerImage', true)
    setObjectCamera('dangerImage', 'hud')
    setProperty('dangerImage.alpha', 0)
    setObjectOrder('dangerImage', 70)

    -- 1 saniyenin kaç step ettiğini hesapla
    if stepCrochet ~= nil and stepCrochet > 0 then
        preSteps = math.floor((1000 / stepCrochet) + 0.5)
        if preSteps < 1 then
            preSteps = 1
        end
    else
        preSteps = 4
    end
end

function startDangerMechanic(timeLimit)
    mechanicActive = true

    setProperty('dangerImage.x', xPositions[math.random(1, #xPositions)])
    setProperty('dangerImage.y', yPositions[math.random(1, #yPositions)])
    setProperty('dangerImage.alpha', 0)

    doTweenAlpha('mecanicaIn', 'dangerImage', 1, 0.7, 'linear')
    runTimer('imageTimer', timeLimit)
end

function endDangerMechanic()
    mechanicActive = false
    cancelTimer('imageTimer')
    doTweenAlpha('mecanicaOut', 'dangerImage', 0, 0.1, 'linear')
    hideMouse()
end

function onStepHit()
    -- Mekanik başlamadan 1 saniye önce cursor aç
    if curStep == 390 - preSteps then
        showMouse()
    elseif curStep == 895 - preSteps then
        showMouse()
    end

    -- Mekaniği başlat
    if curStep == 390 then
        startDangerMechanic(1.5)
    elseif curStep == 895 then
        startDangerMechanic(1.1)
    end
end

function onUpdate(elapsed)
    if not mechanicActive then
        return
    end

    local imgX = getProperty('dangerImage.x')
    local imgY = getProperty('dangerImage.y')
    local imgW = getProperty('dangerImage.width')
    local imgH = getProperty('dangerImage.height')

    local mouseX = getMouseX('hud')
    local mouseY = getMouseY('hud')

    if mouseX > imgX and mouseY > imgY and mouseX < imgX + imgW and mouseY < imgY + imgH and mouseClicked('left') then
        endDangerMechanic()

        -- Eğer bflash kullanıyorsan bu satır kalsın
        doTweenAlpha('nigg', 'bflash', 0, 0.2, 'linear')
    end
end

function onTimerCompleted(tag, loops, loopsLeft)
    if tag == 'imageTimer' then
        mechanicActive = false
        doTweenAlpha('mecanicaFailOut', 'dangerImage', 0, 0.1, 'linear')
        hideMouse()
        setProperty('health', 0)
    end
end

function onDestroy()
    hideMouse()
end