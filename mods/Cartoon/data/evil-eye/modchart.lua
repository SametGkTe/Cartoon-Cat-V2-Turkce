local wasMidscrollOn = false
function onCreate()
end

function onBeatHit()
    if curBeat == 312 then
        for i=0,3 do
            setPropertyFromGroup('opponentStrums', i, 'alpha', 0)
            noteTweenX('xBackAndForth2'..i, i + 4, 92 + (getPropertyFromClass('Note', 'swagWidth') * i) + (screenWidth / 2), 2, 'sineInOut')
        end
        runTimer('backAndForth2', 2, 1)
    end
    if curBeat == 376 then
        for i=0,3 do
            setPropertyFromGroup('opponentStrums', i, 'alpha', 0.35)
            setPropertyFromGroup('playerStrums', i, 'y', _G['defaultPlayerStrumY'..i])
            cancelTween('xBackAndForth1'..i)
            cancelTween('xBackAndForth2'..i)
            noteTweenX("Note7", 4, 410, 0.0001, "sineInOut") -- Izquierda
	noteTweenX("Note4", 5, 526, 0.0001, "sineInOut") -- Abajo
	noteTweenX("Note5", 6, 644, 0.0001, "sineInOut") -- Arriba
	noteTweenX("Note6", 7, 757, 0.0001, "sineInOut") -- Derecha
        end
        cancelTimer('backAndForth1')
        cancelTimer('backAndForth2')
    end
end

function onUpdate(elapsed)
    local currentBeat = (getSongPosition()/5000)*(curBpm/60)
    if curBeat >= 312 and curBeat < 376 then
        for i=0,3 do 
            setPropertyFromGroup('playerStrums', i, 'y', _G['defaultPlayerStrumY'..i] - 20 * math.sin((currentBeat + i*0.25) / 0.5))
        end
    end
end

function backAndForth(num)
    if num == 1 then
        for i=0,3 do
            noteTweenX('xBackAndForth1'..i, i + 4, 92 + (getPropertyFromClass('Note', 'swagWidth') * i), 4, 'sineInOut')
        end
        runTimer('backAndForth1', 4, 1)
    else
        for i=0,3 do
            noteTweenX('xBackAndForth2'..i, i + 4, 92 + (getPropertyFromClass('Note', 'swagWidth') * i) + (screenWidth / 2), 4, 'sineInOut')
        end
        runTimer('backAndForth2', 4, 1)
    end
end

function onTimerCompleted(whatTimer)
    if whatTimer == 'backAndForth1' then
        backAndForth(2)
    end
    if whatTimer == 'backAndForth2' then
        backAndForth(1)
    end
end