local introAllowed = false

function onCreate()
    makeLuaSprite('songscreen','song screens/Thats all Folks',0,0)
    setObjectCamera('songscreen','other')
    scaleObject('songscreen',1.67, 1.67)
    addLuaSprite('songscreen')
    setProperty('camHUD.alpha',0)

    runHaxeCode([[
        FlxG.cameras.remove(game.camOther,false);
        FlxG.cameras.remove(game.camHUD,false);
        var camBAR = new FlxCamera();
        camBAR.bgColor = 0x00;
        setVar('camBAR',camBAR);
        game.getLuaObject('songscreen').camera = camBAR;
        FlxG.cameras.add(camBAR,false);
        FlxG.cameras.add(game.camHUD,false);
        FlxG.cameras.add(game.camOther,false);
    ]])

    makeAnimatedLuaSprite('letrero','letrero', -420, 315)
    addAnimationByPrefix('letrero', 'intro', 'intro', 12, false)
    addLuaSprite('letrero', true)
    scaleObject('letrero',1.6, 1.6)
    setObjectCamera('letrero', 'other')
    setProperty('letrero.alpha',0.0001)

    makeLuaText('name', 'THATS ALL FOLKS', 1080, 155, 320)
    setTextSize('name', 100)
    scaleObject('name',0.2, 0.2)
    setObjectCamera('name', 'other')
    addLuaText('name', true)
    setTextFont('name', 'impact.ttf')
    setProperty('name.alpha', 0)

    makeLuaText('credi', 'BY Kreagato', 780, 180, 350)
    setTextSize('credi', 90)
    scaleObject('credi',0.2, 0.2)
    setObjectCamera('credi', 'other')
    addLuaText('credi', true)
    setTextFont('credi', 'impact.ttf')
    setProperty('credi.alpha', 0)
    setTextColor('credi', 'FF0000')
end

function onStartCountdown()
    -- tafDialogue veya hola henuz bitmemisse bekle
    local tafDone = getVar('tafDialogueDone')
    local holaPlayed = getVar('holaVideoPlayed')

    -- tafDialogue yoksa veya bitmisse VE hola bitmisse -> songscreen goster
    if not introAllowed then
        -- Eger tafDialogue ve hola sistemi varsa, onlarin bitmesini bekle
        if tafDone == false or holaPlayed == false then
            return Function_Continue
        end

        introAllowed = true

        -- Songscreen goster, 3 saniye sonra fade out ve meatnotewarn'a gec
        setProperty('songscreen.alpha', 1)
        runTimer('songscreenTimer', 3)
        return Function_Stop
    end

    return Function_Continue
end

function onTimerCompleted(tag, loops, loopsLeft)
    if tag == 'songscreenTimer' then
        doTweenAlpha('songscreenFade', 'songscreen', 0, 0.4, 'sineInOut')
    end
end

function onTweenCompleted(tag)
    if tag == 'songscreenFade' then
        removeLuaSprite('songscreen', true)
        -- Simdi meatnotewarn'i tetikle
        callOnLuas('showMeatWarn', {})
    end
end

function onCreatePost()
    setProperty('vignetteog.alpha',0)
end

function onSongStart()
    doTweenAlpha('songscreen', 'songscreen', 0, 0.4, 'sineInOut')
    doTweenAlpha('vignetteog', 'vignetteog', 1, 0.2, 'sineInOut')
end

function onStepHit()
    if curStep == 7 then
        removeLuaSprite('songscreen', true)
    elseif curStep == 288 then
        playAnim('letrero', 'intro', true)
        setProperty('letrero.alpha',1)
    elseif curStep == 309 then
        doTweenAlpha('name', 'name', 1, 0.3, 'linear')
    elseif curStep == 310 then
        doTweenAlpha('credi', 'credi', 1, 0.3, 'linear')
    elseif curStep == 339 then
        doTweenX('chaoletrero', 'letrero', -820, 0.8, 'backIn')
        doTweenX('name', 'name', -230, 0.8, 'backIn')
        doTweenX('credi', 'credi', -230, 0.8, 'backIn')
    elseif curStep == 349 then
        removeLuaSprite('letrero', true)
    end
end