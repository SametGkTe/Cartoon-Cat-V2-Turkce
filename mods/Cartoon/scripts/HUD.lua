---@diagnostic disable: undefined-global
function onCreatePost()
    setProperty('iconP1.antialiasing', false)
    setProperty('iconP2.antialiasing', false)
    setProperty('iconGF.antialiasing', false)
    setProperty('iconXD.antialiasing', false)
    setProperty('iconXXD.antialiasing', false)
    setProperty('iconT.antialiasing', false)
    if not hideHud then
    setProperty('scoreTxt.visible', false)

    makeLuaText('scoreCC','Skor: 0 | Iskalar: 0 | Doğruluk: ?',1280,0,0)       
	setProperty('scoreCC.y',getProperty('scoreTxt.y')+2)
	setProperty('scoreCC.x',getProperty('scoreTxt.x')+80)
	setTextWidth('scoreCC',getTextWidth('scoreTxt'))
	setTextAlignment('scoreCC','CENTER')
    setTextSize('scoreCC', 15.5)
    scaleObject('scoreCC', 0.88, 1.3)
	addLuaText('scoreCC', true)
    setObjectOrder('scoreCC',66)
	setTextBorder('scoreCC',1.87, '000000')
    setTextFont('scoreCC', 'Ticketing.ttf')
    if songName == 'Turnaround' then
        setObjectOrder('iconGF',83)
        setProperty('healthBarBG.visible', false);
        makeLuaSprite('CCBar', 'CChealth', 0, getProperty('healthBar.y')-74);
        addLuaSprite('CCBar', true);
	    scaleObject('CCBar', 1.2435, 1.281);
        screenCenter('CCBar', 'x');
	    setProperty('CCBar.x', getProperty('CCBar.x')+5.5)
        setObjectCamera('CCBar', 'camHUD');
        setObjectOrder('CCBar', getObjectOrder('healthBar') + 1);
        scaleObject('healthBar', 1, 2.5);
	    setProperty('healthBar.scale.x', 1.1)
        setObjectOrder('healthBar',4)
        setObjectOrder('CCBar',5)
        if version >= '0.7' then
            scaleObject('healthBar', 1.09, 1.77);
            setProperty('healthBar.x', 10)
            setProperty('healthBar.y', getProperty('healthBar.y')-10)
            addLuaSprite('healthBar', false);
            setObjectOrder('CCBar',50)
            setObjectOrder('iconP1',55)
            setObjectOrder('iconP2',55)
            setObjectOrder('scoreCC',59)
    end
    elseif songName == 'Muscipula' then
        setProperty('healthBarBG.visible', false);
        makeLuaSprite('CCBar', 'WIhealth', 0, getProperty('healthBar.y')-33);
        addLuaSprite('CCBar', true);
        scaleObject('CCBar', 1.2535, 1.281);
        screenCenter('CCBar', 'x');
        setProperty('CCBar.x', getProperty('CCBar.x')+5.5)
        setObjectCamera('CCBar', 'camHUD');
        setObjectOrder('CCBar', getObjectOrder('healthBar') + 1);
        scaleObject('healthBar', 1, 2.5);
        setProperty('healthBar.scale.x', 1.1)
        setObjectOrder('healthBar',4)
        setObjectOrder('CCBar',5)
        removeLuaText('scoreCC', true)
        if version >= '0.7' then
            scaleObject('healthBar', 1.09, 1.6);
            setProperty('healthBar.x', 10)
            setProperty('healthBar.y', getProperty('healthBar.y')-10)
            addLuaSprite('healthBar', false);
            setObjectOrder('CCBar',50)
            setObjectOrder('iconP1',55)
            setObjectOrder('iconP2',55)
            setObjectOrder('scoreCC',59)
    end
    elseif songName == 'Evil Eye' then
        setProperty('healthBarBG.visible', false);
        makeLuaSprite('CCBar', 'CChealth1', 0, getProperty('healthBar.y')-55);
        addLuaSprite('CCBar', true);
        scaleObject('CCBar', 1.2515, 1.241);
        screenCenter('CCBar', 'x');
        setProperty('CCBar.x', getProperty('CCBar.x')+5.5)
        setObjectCamera('CCBar', 'camHUD');
        setObjectOrder('CCBar', getObjectOrder('healthBar') + 1);
        scaleObject('healthBar', 1, 2);
        setObjectOrder('healthBar',4)
        setObjectOrder('CCBar',5)
        setProperty('healthBar.scale.x', 1.1)
        if version >= '0.7' then
            scaleObject('healthBar', 1.09, 1.6);
            setProperty('healthBar.x', 12)
            setProperty('healthBar.y', getProperty('healthBar.y')-10)
            addLuaSprite('healthBar', false);
            setObjectOrder('CCBar',50)
            setObjectOrder('iconP1',55)
            setObjectOrder('iconP2',55)
            setObjectOrder('scoreCC',59)
    end
    elseif songName == 'Toon Swing' then
        setProperty('healthBarBG.visible', false);
        makeLuaSprite('CCBar', 'CChealth3', 0, getProperty('healthBar.y')-121);
        addLuaSprite('CCBar', true);
        scaleObject('CCBar', 1.2435, 1.281);
        screenCenter('CCBar', 'x');
        setProperty('CCBar.x', getProperty('CCBar.x')+5.5)
        setObjectCamera('CCBar', 'camHUD');
        setObjectOrder('CCBar', getObjectOrder('healthBar') + 1);
        scaleObject('healthBar', 1, 2);
        setProperty('healthBar.scale.x', 1.1)
        setObjectOrder('healthBar',4)
        setObjectOrder('CCBar',5)
        if version >= '0.7' then
            scaleObject('healthBar', 1.09, 1.6);
            setProperty('healthBar.x', 12)
            setProperty('healthBar.y', getProperty('healthBar.y')-10)
            addLuaSprite('healthBar', false);
            setObjectOrder('CCBar',50)
            setObjectOrder('iconP1',55)
            setObjectOrder('iconP2',55)
            setObjectOrder('scoreCC',59)
    end
    elseif songName == 'Cursed Cat' then
        setProperty('healthBarBG.visible', false);
        makeLuaSprite('CCBar', 'CCEXEhealth', 0, getProperty('healthBar.y')-40);
        addLuaSprite('CCBar', true);
        scaleObject('CCBar', 1.2435, 1.281);
        screenCenter('CCBar', 'x');
        setProperty('CCBar.x', getProperty('CCBar.x')+5.8)
        setObjectCamera('CCBar', 'camHUD');
        setObjectOrder('CCBar', getObjectOrder('healthBar') + 1);
        scaleObject('healthBar', 1, 2);
        setProperty('healthBar.scale.x', 1.1)
        setProperty('CCBar.antialiasing',false)
        setTextFont('scoreCC', 'gatoexe.ttf')
        scaleObject('scoreCC', 1.3, 1.3)
        setProperty('scoreCC.x',getProperty('scoreTxt.x')-190)
        if version >= '0.7' then
            scaleObject('healthBar', 1.09, 1.09);
            setProperty('healthBar.x', 10)
            setProperty('healthBar.y', getProperty('healthBar.y')-10)
            addLuaSprite('healthBar', false);
            setObjectOrder('iconP1',55)
            setObjectOrder('iconP2',55)
            setObjectOrder('scoreCC',59)
        end
    elseif songName == 'Sana Mi Dolor' or songName == 'evileyeold.json' then
        setProperty('healthBarBG.visible', true);
        setObjectOrder('healthBar', 3)
        setObjectOrder('healthBarBG', 1)
        if version >= '0.7' then
            scaleObject('healthBar', 1.09, 1.09);
            setProperty('healthBar.x', 10)
            setProperty('healthBar.y', getProperty('healthBar.y')-10)
        end
    elseif songName == 'Distant Alarm' then
        setTextFont('scoreCC', 'impact.ttf')
        scaleObject('scoreCC', 1.3, 1.3)
        setProperty('scoreCC.x',getProperty('scoreTxt.x')-190)
        setProperty('healthBarBG.visible', false);
        makeLuaSprite('CCBar', 'CChealth2', 0, getProperty('healthBar.y')-54);
        addLuaSprite('CCBar', true);
        scaleObject('CCBar', 0.9253, 0.968);
        screenCenter('CCBar', 'x');
        setProperty('CCBar.x', getProperty('CCBar.x')+5.5)
        setObjectCamera('CCBar', 'camHUD');
        setObjectOrder('CCBar', getObjectOrder('healthBar') + 1);
        scaleObject('healthBar', 1, 2);
        setProperty('healthBar.scale.x', 1.1)
        setObjectOrder('healthBar',8)
        setObjectOrder('CCBar',9)
        setProperty('CCBar.antialiasing',false)
        if version >= '0.7' then
            scaleObject('healthBar', 1.1, 1.6);
            setProperty('healthBar.x', 10)
            setProperty('healthBar.y', getProperty('healthBar.y')-11)
            addLuaSprite('healthBar', false);
            setObjectOrder('CCBar',50)
            setObjectOrder('iconP1',55)
            setObjectOrder('iconP2',55)
            setObjectOrder('scoreCC',59)
end
    elseif songName == 'Thats all Folks' then
        setProperty('healthBarBG.visible', false);
        makeLuaSprite('CCBar2', 'CCBosshealth2', 0, getProperty('healthBar.y')-47);
        addLuaSprite('CCBar2', false);
        scaleObject('CCBar2', 1.2435, 1.261);
        screenCenter('CCBar2', 'x');
        setProperty('CCBar2.x', getProperty('CCBar2.x')+5.5)
        setObjectCamera('CCBar2', 'camHUD');
        setObjectOrder('CCBar2', 4)
        setProperty('CCBar2.alpha', 1)

        makeLuaSprite('CCBar1', 'CCBosshealth1', 0, getProperty('healthBar.y')-77);
        addLuaSprite('CCBar1', true);
        scaleObject('CCBar1', 1.2435, 1.255);
        screenCenter('CCBar1', 'x');
        setProperty('CCBar1.x', getProperty('CCBar2.x'))
        setObjectCamera('CCBar1', 'camHUD');
        setProperty('CCBar1.alpha', 1)
        setObjectOrder('CCBar1', 5)
        setObjectOrder('healthBar',3)
        setProperty('healthBarBG.visible', false);
    else
        setProperty('healthBarBG.visible', false);
        makeLuaSprite('CCBar', 'CChealth2', 0, getProperty('healthBar.y')-54);
        addLuaSprite('CCBar', true);
        scaleObject('CCBar', 0.9253, 0.968);
        screenCenter('CCBar', 'x');
        setProperty('CCBar.x', getProperty('CCBar.x')+5.5)
        setObjectCamera('CCBar', 'camHUD');
        setObjectOrder('CCBar', getObjectOrder('healthBar') + 1);
        scaleObject('healthBar', 1, 2);
        setProperty('healthBar.scale.x', 1.1)
        setObjectOrder('healthBar',8)
        setObjectOrder('CCBar',9)
        setProperty('CCBar.antialiasing',false)

        if version >= '0.7' then
            scaleObject('healthBar', 1.1, 1.6);
            setProperty('healthBar.x', 10)
            setProperty('healthBar.y', getProperty('healthBar.y')-11)
            addLuaSprite('healthBar', false);
            setObjectOrder('CCBar', getObjectOrder('healthBar')+10)
            setObjectOrder('iconP1',55)
            setObjectOrder('iconP2',55)
            setObjectOrder('scoreCC',59)
            setTextBorder('scoreCC',1.2, '000000')
    end
end
end
function onUpdatePost(elapsed)
    setTextString('scoreCC','Skor: '..score..' | Iskalar: '..misses..' | Doğruluk: ['..(math.floor(getProperty('ratingPercent') * 10000)/100)..'% - '..ratingFC..']')
    if version >= '0.7' then
        setProperty('iconP1.x', getProperty('iconP1.x')+335)
        setProperty('iconP2.x', getProperty('iconP2.x')+330)
        if songName == 'Thats all Folks' then
        setProperty('iconP1.x', getProperty('iconP1.x')-325)
        setProperty('iconP2.x', getProperty('iconP2.x')-320)
        setObjectOrder('CCBar2', 64);
        setObjectOrder('CCBar1', 5);
        setObjectOrder('iconP1', 65);
        setObjectOrder('iconP2', 65);
        setProperty('healthBar.y', 637)
        setObjectOrder('scoreCC',66)
        if downscroll then
        setProperty('healthBar.y', 75)
        end
        end
    end
end
end