function onCreate()
end

function onCreatePost()
    setProperty('camHUD.alpha', 0)
    setProperty('CCBar1.alpha', 0.00001)
    setProperty('CCBar2.alpha', 0.00001)
    setProperty('healthBar.alpha', 0.00001)
    setProperty('iconP1.alpha', 0.00001)
    setProperty('iconP2.alpha', 0.00001)
    setProperty('scoreTxt.alpha', 0.00001)
    setProperty('timeBarBG.visible', false)
    setProperty('timeBar.visible', false)
    setProperty('timeTxt.visible', false)

    setProperty('boyfriend.alpha', 0.00001)
    setProperty('dad.alpha', 0.00001)

    setProperty('camFollow.x', 675)
    setProperty('camFollow.y', 500)

    if not lowQuality then
        makeLuaSprite('vignette', 'cc/cc_go', 0, 0)
        setObjectCamera('vignette', 'hud')
        addLuaSprite('vignette', false)
        scaleObject('vignette', 2, 2)
        setObjectOrder('vignette', 0)
    end
end

function onSongStart()
    doTweenZoom('startZoomShit', 'camGame', 0.8, 9.0)
end

function onUpdatePost()
    local currentBeat = (getSongPosition() / 1000) * (curBpm / 60)

    if (curStep >= 288 and curStep < 1568) and not (curStep >= 799 and curStep < 1056) then
        if mustHitSection then
            setProperty('defaultCamZoom', 1.2)
        else
            setProperty('defaultCamZoom', 0.6)
        end
    end

    if curBeat >= 912 and curBeat < 976 then
        for i = 0, 3 do
            setPropertyFromGroup('opponentStrums', i, 'y', _G['defaultOpponentStrumY' .. i] - 25 * math.sin((currentBeat + i * 0.25) * math.pi))
            setPropertyFromGroup('playerStrums', i, 'y', _G['defaultPlayerStrumY' .. i] - 25 * math.sin((currentBeat + (i + 3) * 0.25) * math.pi))
        end
    end

    if curBeat >= 600 and curBeat < 684 then
        for i = 0, 3 do
            if not middlescroll then
                setPropertyFromGroup('opponentStrums', i, 'x', _G['defaultPlayerStrumX' .. i] + 32 * math.sin(currentBeat + i * 7))
                setPropertyFromGroup('playerStrums', i, 'x', _G['defaultOpponentStrumX' .. i] + 32 * math.sin(currentBeat + (i + 4) * 7))
            else
                setPropertyFromGroup('opponentStrums', i, 'x', _G['defaultOpponentStrumX' .. i] + 32 * math.sin(currentBeat + i * 7))
                setPropertyFromGroup('playerStrums', i, 'x', _G['defaultPlayerStrumX' .. i] + 32 * math.sin(currentBeat + (i + 4) * 7))
            end
        end
    end
end

function onStepHit()
    if curStep == 112 then
        noteTweenAlpha('noteFadeIn3', 4, 1, 0.5, 'quadInOut')
        doTweenAlpha('STIN', 'ST', 1, 1, 'linear')
    end

    if curStep == 128 then
        setProperty('camHUD.alpha', 1)
        setProperty('boyfriend.alpha', 1)
        setProperty('dad.alpha', 1)
        setProperty('ST.alpha', 0)
        removeLuaSprite('ST', true)

        if not lowQuality then
            setProperty('vignette.alpha', 0.5)
        end
    end

    if curStep == 264 then
        for i = 0, 3 do
            noteTweenY('noteDown' .. i, i, _G['defaultOpponentStrumY' .. i] + 200, 1 + (i * 0.2), 'quadInOut')
            noteTweenAlpha('noteFade' .. i, i, 0.00001, 1 + (i * 0.2), 'quadInOut')
        end
    end

    if curStep == 288 then
        for i = 0, 3 do
            setPropertyFromGroup('opponentStrums', i, 'y', _G['defaultOpponentStrumY' .. i])
        end

        setProperty('CCBar2.alpha', 1)
        setProperty('CCBar1.alpha', 1)
        setProperty('healthBar.alpha', 1)
        setProperty('iconP1.alpha', 1)
        setProperty('iconP2.alpha', 1)
        setProperty('scoreTxt.alpha', 1)
        setProperty('timeBarBG.visible', true)
        setProperty('timeBar.visible', true)
        setProperty('timeTxt.visible', true)

        cameraFlash('game', '0xFFFF0000', 1.5, true)
        cameraFlash('other', '0xFFFF0000', 1.5, true)

        if not lowQuality then
            setProperty('vignette.alpha', 0.00001)
        end
    end

    if curStep == 3328 then
        noteTweenX('Movement X 0', 0, -1000, 0.9)
        noteTweenX('Movement X 1', 1, -1000, 0.9)
        noteTweenX('Movement X 2', 2, -1000, 0.9)
        noteTweenX('Movement X 3', 3, -1000, 0.9)

        noteTweenX('Movement X 4', 4, 415, 0.9)
        noteTweenX('Movement X 5', 5, 525, 0.9)
        noteTweenX('Movement X 6', 6, 635, 0.9)
        noteTweenX('Movement X 7', 7, 745, 0.9)

        setProperty('CCBar1.alpha', 0)
        setProperty('CCBar2.alpha', 0)
    end

    if curStep == 3904 then
        for i = 0, 3 do
            setPropertyFromGroup('opponentStrums', i, 'y', _G['defaultOpponentStrumY' .. i])
            setPropertyFromGroup('playerStrums', i, 'y', _G['defaultPlayerStrumY' .. i])
        end
    end
end