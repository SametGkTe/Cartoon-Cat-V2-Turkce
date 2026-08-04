function onEvent(name, value1, value2)
    if name == "Default Cam Zoom" then
        setProperty("defaultCamZoom", value1)
        if value1 ~= '' then
            setProperty("camGame.zoom", value1)
        end
    end
end

function onUpdatePost(elapsed)
    if songName == 'Evil Eye' or songName == 'evileyeold.json' then
        if keyboardJustPressed('SPACE') then
            makeLuaSprite('a', 'cc/leovincible/gloria', 0, 0)
            setObjectOrder('a', 70)
            scaleObject('a', 1.5, 1.5)
            addLuaSprite('a', true)
            setObjectCamera('a', 'other')
            setProperty('camHUD.visible', false)
            setPropertyFromClass('PlayState', 'instance.vocals.volume', 0)
            setPropertyFromClass('flixel.FlxG', 'sound.music.volume', 0)
            setPropertyFromClass('PlayState', 'instance.generatedMusic', false)
            setProperty('vocals.time', getPropertyFromClass('Conductor', 'songPosition'))
        end

    elseif songName == 'Cartoon Jam' then
        if keyboardJustPressed('SPACE') then
            runTimer('comer', 0.0001)
        end

    elseif songName == 'Toon Swing' then
        if keyboardJustPressed('SPACE') then
            makeLuaSprite('a', 'cc/park/jacob', 0, 0)
            setObjectOrder('a', 70)
            scaleObject('a', 1.6, 1.6)
            addLuaSprite('a', true)
            setObjectCamera('a', 'hud')
            playSound('a', 0.99)
            runTimer('a', 0.8)
            triggerEvent('Screen Shake', '1, 0.01', '1, 0.01')
        end
    end
end

function onTimerCompleted(tag, loops, loopsLeft)
    if tag == 'a' then
        doTweenAlpha('w', 'a', 0, 2, 'easeIn')
    end
end

function onCreate()
end