function onCreatePost() -- hecho por lio, mejorado y randomizado por zJosiz :skull:
    makeLuaSprite('dangerImage', 'cc/forest/circle', 0, 0)
    addLuaSprite('dangerImage', true)
    setObjectCamera('dangerImage','hud')
    setProperty('dangerImage.alpha', 0);
    setObjectOrder('dangerImage', 70)
end
function onStepHit()
    if curStep == 390 then 
        runTimer('imageTimer', 1.5)
        runTimer('MeWhen', 0.0001)
        runTimer('YMeWhen', 0.0001)
        doTweenAlpha('mecanica', 'dangerImage', 1, 0.7, 'linear')
    elseif curStep == 895 then 
        runTimer('imageTimer', 1.1)
        doTweenAlpha('mecanica', 'dangerImage', 1, 0.7, 'linear')
    end
end
function onUpdate(elapsed)
    MeWhen = math.random(1,6)
    YMeWhen = math.random(1,4)
    if getProperty('dangerImage.visible') then
 if getMouseX('hud') > getProperty('dangerImage.x') and getMouseY('hud') > getProperty('dangerImage.y') and getMouseX('hud') < getProperty('dangerImage.x') 
 + getProperty('dangerImage.width') and getMouseY('hud') < getProperty('dangerImage.y') + getProperty('dangerImage.height') and mouseClicked('left') then
    doTweenAlpha('mecanica', 'dangerImage', 0, 0.1, 'linear')
            runTimer('PutaMadreMeVoyASuicidar', 1)
            doTweenAlpha('nigg', 'bflash', 0, 0.2, 'linear')
            cancelTimer('imageTimer')
            setPropertyFromClass('flixel.FlxG', 'mouse.visible', false);
        end
    end
end
function onTimerCompleted(tag, loops, loopsLeft)
    if tag == 'PutaMadreMeVoyASuicidar' then
        runTimer('MeWhen', 0.0001)
        runTimer('YMeWhen', 0.0001)
    end
    if tag == 'imageTimer' then
        setProperty('health', 0)  -- Matar al jugador
    end
    if tag == 'MeWhen' then
if MeWhen == 1 then
    setProperty('dangerImage.x', 1100)
 end
 if MeWhen == 2 then
    setProperty('dangerImage.x', 900)
end
if MeWhen == 3 then
    setProperty('dangerImage.x', 650)
end
if MeWhen == 4 then
    setProperty('dangerImage.x', 300)
end
if MeWhen == 5 then
    setProperty('dangerImage.x', 140)
end
if MeWhen == 6 then
    setProperty('dangerImage.x', 50)
end
end
if tag == 'YMeWhen' then
    if YMeWhen == 1 then
        setProperty('dangerImage.y', 190)
     end
     if YMeWhen == 2 then
        setProperty('dangerImage.y', 250)
    end
    if YMeWhen == 3 then
        setProperty('dangerImage.y', 350)
    end
    if YMeWhen == 4 then
        setProperty('dangerImage.y', 500)
    end
end
end
function onDestroy()
    setPropertyFromClass('flixel.FlxG', 'mouse.visible', false);
end