local introStep = 0

function onStartCountdown()
    if seenCutscene then
        return Function_Continue
    end

    if isStoryMode and introStep == 0 then
        introStep = 1
        startVideo('newrerunscutscene')
        return Function_Stop
    end

    if introStep < 2 then
        introStep = 2

        makeLuaSprite('warnImage', 'meatnotewarn', 0, 0)
        setObjectCamera('warnImage', 'other')
        addLuaSprite('warnImage', true)
        updateHitbox('warnImage')

        local xPos = screenWidth - getProperty('warnImage.width') + 330
        local yPos = screenHeight - getProperty('warnImage.height') + 220

        setProperty('warnImage.x', xPos)
        setProperty('warnImage.y', yPos)

        runTimer('startSongTimer', 3)
        return Function_Stop
    end

    return Function_Continue
end

function onTimerCompleted(tag)
    if tag == 'startSongTimer' then
        doTweenAlpha('byeImage', 'warnImage', 0, 0.5, 'linear')
    end
end

function onTweenCompleted(tag)
    if tag == 'byeImage' then
        removeLuaSprite('warnImage', true)
        setPropertyFromClass('states.PlayState', 'seenCutscene', true)

        startCountdown()
    end
end