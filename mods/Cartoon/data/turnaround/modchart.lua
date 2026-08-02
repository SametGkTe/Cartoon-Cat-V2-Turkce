function onCreatePost()
    for i=0,3 do
        if downscroll == false then
            setPropertyFromGroup('opponentStrums', i, 'downScroll', true)
        else
            setPropertyFromGroup('opponentStrums', i, 'downScroll', false)
        end
    end
    
end

function onSongStart()
    runTimer('hudAlphaTimer', 0.1, 0)
end

function onBeatHit()
    if curBeat == 1 then
        for i=0,3 do
            if downscroll == false then
                setPropertyFromGroup('opponentStrums', i, 'downScroll', true)
            else
                setPropertyFromGroup('opponentStrums', i, 'downScroll', false)
            end
        end
    end
    if curBeat == 232 then
        setProperty('camHUD.angle', 0)
        for i=0,7 do
            noteTweenAngle('resetA'..i, i, 0, 0.25)
        end
    end
    if curBeat == 136 or curBeat == 152 or curBeat == 232 or curBeat == 248 then
        doTweenAngle('flipHUD', 'camHUD', 180, 0.25, 'quadOut')
        doTweenAngle('flipGame', 'camGame', -180, 0.25, 'quadOut')
    end
    if curBeat == 140 or curBeat == 148 or curBeat == 156 or curBeat == 164 or curBeat == 236 or curBeat == 244 or curBeat == 252 or curBeat == 260 then
        doTweenAngle('flipHUD', 'camHUD', 0, 0.25, 'quadOut')
        doTweenAngle('flipGame', 'camGame', 0, 0.25, 'quadOut')
    end
    if curBeat == 144 or curBeat == 160 or curBeat == 240 or curBeat == 256 then
        doTweenAngle('flipHUD', 'camHUD', -180, 0.25, 'quadOut')
        doTweenAngle('flipGame', 'camGame', 180, 0.25, 'quadOut')
    end
    if curBeat == 328 then
        doTweenAlpha('dadFade', 'dad', 0, 3.5)
        doTweenAlpha('dadIconFade', 'iconP2', 0, 3.5)
        for i=0,3 do
            noteTweenAlpha('dadNoteFade'..i, i, 0, 3.5)
        end
    end
end

function onUpdate(elapsed)
    local currentBeat = (getSongPosition()/5000)*(curBpm/60)
    if curBeat >= 168 and curBeat < 200 then
        doTweenAngle('hudwweeeeww', 'camHUD', 4*math.sin((currentBeat+12)*math.pi), 0.1)
        for i=0,7 do
            noteTweenAngle('a'..i, i, -4*math.sin((currentBeat+12)*math.pi), 0.1)
        end
    end
    if curBeat >= 200 and curBeat < 232 then
        doTweenAngle('hudwweeeeww', 'camHUD', 8*math.sin((currentBeat+12)*math.pi), 0.1)
        for i=0,7 do
            noteTweenAngle('a'..i, i, -8*math.sin((currentBeat+12)*math.pi), 0.1)
        end
    end
    if curBeat < 1 then
        for i=0,3 do
            if downscroll == false then
                setPropertyFromGroup('opponentStrums', i, 'y', 500)
            else
                setPropertyFromGroup('opponentStrums', i, 'y', 120)
            end
        end
    end
end

function noteMiss(membersIndex, noteData, noteType, isSustainNote)
    if not isSustainNote and getProperty('camHUD.alpha') > 0 then
        setProperty('camHUD.alpha', getProperty('camHUD.alpha') - 0.1)
    end
end

function onTimerCompleted(tag, loops, loopsLeft)
    if tag == 'hudAlphaTimer' then
        if getProperty('camHUD.alpha') < 1 then
            setProperty('camHUD.alpha', getProperty('camHUD.alpha') + 0.005)
        end
    end
end