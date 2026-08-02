function onBeatHit()
    if curBeat == 96 then
        for i=0,3 do
            if middlescroll then
            noteTweenY('returnY'..i, i, _G['defaultOpponentStrumY'..i], 0.5, 'sineInOut')
            noteTweenY('returnY'..i + 4, i + 4, _G['defaultPlayerStrumY'..i], 0.5, 'sineInOut')
            else
            noteTweenY('returnY'..i, i, _G['defaultPlayerStrumY'..i], 0.5, 'sineInOut')
            noteTweenY('returnY'..i + 4, i + 4, _G['defaultOpponentStrumY'..i], 0.5, 'sineInOut')
        end
    end
    end
    if curBeat == 192 or curBeat == 320 then
        for i=0,3 do
            if middlescroll then
            noteTweenX('returnX'..i, i, _G['defaultOpponentStrumX'..i], 0.5, 'sineInOut')
            noteTweenX('returnX'..i + 4, i + 4, _G['defaultPlayerStrumX'..i], 0.5, 'sineInOut')
            noteTweenY('returnY'..i, i, _G['defaultOpponentStrumY'..i], 0.5, 'sineInOut')
            noteTweenY('returnY'..i + 4, i + 4, _G['defaultPlayerStrumY'..i], 0.5, 'sineInOut')
            else
            noteTweenX('returnX'..i, i, _G['defaultPlayerStrumX'..i], 0.5, 'sineInOut')
            noteTweenX('returnX'..i + 4, i + 4, _G['defaultOpponentStrumX'..i], 0.5, 'sineInOut')
            noteTweenY('returnY'..i, i, _G['defaultPlayerStrumY'..i], 0.5, 'sineInOut')
            noteTweenY('returnY'..i + 4, i + 4, _G['defaultOpponentStrumY'..i], 0.5, 'sineInOut')
        end
    end
end
end

function onSectionHit()

end

function onUpdate(elapsed)
    local currentBeat = (getSongPosition()/1000)*(curBpm/60)
    if curBeat < 192 then
        for i=0,3 do
            if middlescroll then
            setPropertyFromGroup('strumLineNotes', i, 'x', _G['defaultOpponentStrumX'..i] + 16 * math.sin(currentBeat))
            setPropertyFromGroup('strumLineNotes', i + 4, 'x', _G['defaultPlayerStrumX'..i] - 16 * math.sin(currentBeat))
            else
            setPropertyFromGroup('strumLineNotes', i, 'x', _G['defaultPlayerStrumX'..i] + 16 * math.sin(currentBeat))
            setPropertyFromGroup('strumLineNotes', i + 4, 'x', _G['defaultOpponentStrumX'..i] - 16 * math.sin(currentBeat))
        end
    end
    elseif curBeat < 256 then
        for i=0,3 do
            if middlescroll then
            setPropertyFromGroup('strumLineNotes', i, 'x', _G['defaultOpponentStrumX'..i] + 16 * math.sin(currentBeat + i))
            setPropertyFromGroup('strumLineNotes', i + 4, 'x', _G['defaultPlayerStrumX'..i] - 16 * math.sin(currentBeat + i))
            else
            setPropertyFromGroup('strumLineNotes', i, 'x', _G['defaultPlayerStrumX'..i] + 16 * math.sin(currentBeat + i))
            setPropertyFromGroup('strumLineNotes', i + 4, 'x', _G['defaultOpponentStrumX'..i] - 16 * math.sin(currentBeat + i))
        end
    end
end
    if (curBeat >= 64 and curBeat < 96) or (curBeat >= 160 and curBeat < 192) then
        for i=0,3 do
            if middlescroll then
            setPropertyFromGroup('strumLineNotes', i, 'y', _G['defaultOpponentStrumY'..i] + 16 * math.sin(currentBeat + i))
            setPropertyFromGroup('strumLineNotes', i + 4, 'y', _G['defaultPlayerStrumY'..i] - 16 * math.sin(currentBeat + i))
            else
            setPropertyFromGroup('strumLineNotes', i, 'y', _G['defaultPlayerStrumY'..i] + 16 * math.sin(currentBeat + i))
            setPropertyFromGroup('strumLineNotes', i + 4, 'y', _G['defaultOpponentStrumY'..i] - 16 * math.sin(currentBeat + i))
        end
    end
end
    if curBeat >= 256 and curBeat < 320 then
        for i=0,3 do
            if middlescroll then
            setPropertyFromGroup('strumLineNotes', i, 'x', _G['defaultOpponentStrumX'..i] + 32 * math.sin(currentBeat + i))
            setPropertyFromGroup('strumLineNotes', i + 4, 'x', _G['defaultPlayerStrumX'..i] - 32 * math.sin(currentBeat + i))
            setPropertyFromGroup('strumLineNotes', i, 'y', _G['defaultOpponentStrumY'..i] + 16 * math.sin(currentBeat + i))
            setPropertyFromGroup('strumLineNotes', i + 4, 'y', _G['defaultPlayerStrumY'..i] - 16 * math.sin(currentBeat + i))
            else
            setPropertyFromGroup('strumLineNotes', i, 'x', _G['defaultPlayerStrumX'..i] + 32 * math.sin(currentBeat + i))
            setPropertyFromGroup('strumLineNotes', i + 4, 'x', _G['defaultOpponentStrumX'..i] - 32 * math.sin(currentBeat + i))
            setPropertyFromGroup('strumLineNotes', i, 'y', _G['defaultPlayerStrumY'..i] + 16 * math.sin(currentBeat + i))
            setPropertyFromGroup('strumLineNotes', i + 4, 'y', _G['defaultOpponentStrumY'..i] - 16 * math.sin(currentBeat + i))
        end
    end
end
end