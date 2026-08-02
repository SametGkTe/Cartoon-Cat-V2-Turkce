local allowCountdown = false

function onStartCountdown()
    if not allowCountdown then
        makeLuaSprite('warnImage', 'meatnotewarn', 0, 0)
        setObjectCamera('warnImage', 'other') -- En üst katmana
        addLuaSprite('warnImage', true)
        updateHitbox('warnImage')
        
		-- KONUM
        local xPos = screenWidth - getProperty('warnImage.width') + 330
        local yPos = screenHeight - getProperty('warnImage.height') + 220
        
        setProperty('warnImage.x', xPos)
        setProperty('warnImage.y', yPos)
        
        -- 3 saniye sonra ggs
        runTimer('startSongTimer', 3)
        
        allowCountdown = true
        return Function_Stop
    end
    return Function_Continue
end

function onTimerCompleted(tag, loops, loopsLeft)
    if tag == 'startSongTimer' then
        -- Tween
        doTweenAlpha('byeImage', 'warnImage', 0, 0.5, 'linear')
    end
end

function onTweenCompleted(tag)
    if tag == 'byeImage' then
        removeLuaSprite('warnImage', true)
        startCountdown() -- Şarkıyı başlat
    end
end