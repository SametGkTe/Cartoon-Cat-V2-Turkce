local videoPlayed = false
local warningPlayed = false

function onStartCountdown()
    if isStoryMode and not videoPlayed then
        videoPlayed = true
        startVideo('newrerunscutscene')
        return Function_Stop
    end

    if not warningPlayed then
        warningPlayed = true

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
        startCountdown()
    end
end