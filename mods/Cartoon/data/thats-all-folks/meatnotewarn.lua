function showMeatWarn()
    makeLuaSprite('warnImage', 'meatnotewarn', 0, 0)
    setObjectCamera('warnImage', 'other')
    addLuaSprite('warnImage', true)
    updateHitbox('warnImage')

    local xPos = screenWidth - getProperty('warnImage.width') + 330
    local yPos = screenHeight - getProperty('warnImage.height') + 220

    setProperty('warnImage.x', xPos)
    setProperty('warnImage.y', yPos)

    runTimer('startSongTimer', 3)
end

function onTimerCompleted(tag, loops, loopsLeft)
    if tag == 'startSongTimer' then
        doTweenAlpha('byeImage', 'warnImage', 0, 0.5, 'linear')
    end
end

function onTweenCompleted(tag)
    if tag == 'byeImage' then
        removeLuaSprite('warnImage', true)
        startCountdown()
    end
end