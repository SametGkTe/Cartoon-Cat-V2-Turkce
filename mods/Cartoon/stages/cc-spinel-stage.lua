function onCreate()
makeLuaSprite('casa','cc/spinel_cat/mi_casa_tio',-600, -400)
addLuaSprite('casa')
scaleObject('casa', 2, 2)

makeLuaSprite('cn','cc/spinel_cat/cn_premiere',1070, 580)
addLuaSprite('cn', true)
setObjectCamera('cn', 'other')
scaleObject('cn', 1, 1)
setProperty('cn.antialiasing',false)
setObjectOrder('cn', 50);

	makeAnimatedLuaSprite('amatista','cc/spinel_cat/las_cristales', 815, 473)
    addAnimationByPrefix('amatista', 'idle', 'amatista', 24, true);
	addAnimationByPrefix('amatista', 'comiendo', 'animacion comiendo', 24, false);
    scaleObject('amatista',1.2, 1.2)
    addLuaSprite('amatista', false)

	makeAnimatedLuaSprite('carne','cc/spinel_cat/las_cristales', 596, 267)
    addAnimationByPrefix('carne', 'idle', 'carne', 24, true);
    scaleObject('carne',1, 1)
    addLuaSprite('carne', false)

	makeAnimatedLuaSprite('perla','cc/spinel_cat/las_cristales', 290, 320)
    addAnimationByPrefix('perla', 'idle', 'perla', 24, true);
    scaleObject('perla',1.2, 1.2)
    addLuaSprite('perla', false)

	makeLuaSprite('rosa', '', 230, 100);
    makeGraphic('rosa',760,420,'D408AE')
    addLuaSprite('rosa', false);
    setLuaSpriteScrollFactor('rosa',0,0)
    setProperty('rosa.scale.x',3.7)
    setProperty('rosa.scale.y',3.8)
	setProperty('rosa.alpha', 0.0000001)

	if lowQuality then
        makeLuaSprite('bflash', '', 0, 0);
        makeGraphic('bflash',680,340,'000000')
        addLuaSprite('bflash', false);
        setLuaSpriteScrollFactor('bflash',0,0)
        setProperty('bflash.scale.x',3)
        setProperty('bflash.scale.y',3.4)
        setProperty('bflash.antialiasing',false)
        end
end
function onCreatePost()
	removeLuaSprite('static', true)
	removeLuaSprite('vignetteog', true)
		doTweenColor('dad', 'dadGroup', 'FFC2FD', 0.1, 'linear')
		doTweenColor('boyfriend', 'boyfriendGroup', 'FFC2FD', 0.1, 'linear')
		doTweenColor('a', 'amatista', 'FFC2FD', 0.1, 'linear')
		doTweenColor('c', 'carne', 'FFC2FD', 0.1, 'linear')
		doTweenColor('p', 'perla', 'FFC2FD', 0.1, 'linear')
		setObjectCamera('bflash','other')
		setProperty('bflash.alpha', 1)
		runTimer('comer', 3)
		if downscroll then
		setProperty('cn.y', 40)
		end
	end
function onTimerCompleted(tag, loops, loopsLeft)
    if tag == 'comer' then
		setProperty('amatista.x', 826)
		setProperty('amatista.y', 481)
		objectPlayAnimation('amatista', 'comiendo', true)
		runTimer('comer2', 0.4)
    end
	if tag == 'comer2' then
		setProperty('amatista.x', 815)
		setProperty('amatista.y', 473)
		objectPlayAnimation('amatista', 'idle', true)
		runTimer('comer3', 2)
end
if tag == 'comer3' then
	setProperty('amatista.x', 826)
	setProperty('amatista.y', 481)
	objectPlayAnimation('amatista', 'comiendo', true)
	runTimer('comer4', 0.4)
end
if tag == 'comer4' then
	setProperty('amatista.x', 815)
		setProperty('amatista.y', 473)
	objectPlayAnimation('amatista', 'idle', true)
	runTimer('comer', 5)
end
end
	function onStepHit()
		if curStep == 57 then
		doTweenAlpha('hoa', 'bflash', 0, 7, 'linear')
		elseif curStep == 384 then
		setProperty('rosa.alpha', 1)
		doTweenColor('dad', 'dadGroup', '000000', 0.01, 'linear')
		doTweenColor('boyfriend', 'boyfriendGroup', '000000', 0.01, 'linear')
		doTweenColor('e', 'noteCombo', '000000', 0.01, 'linear')
		elseif curStep == 509 then
		removeLuaSprite('rosa', true)
		setProperty('bflash.alpha', 1)
		doTweenColor('dad', 'dadGroup', 'FFC2FD', 0.01, 'linear')
		doTweenColor('boyfriend', 'boyfriendGroup', 'FFC2FD', 0.01, 'linear')
		doTweenColor('e', 'noteCombo', 'FFFFFF', 0.01, 'linear')
	    elseif curStep == 769 then
		doTweenColor('dad', 'dadGroup', 'FEC1FD', 0.001, 'linear')
	    elseif curStep == 833 then
		doTweenColor('dad', 'dadGroup', 'FFC2FD', 0.001, 'linear')
	    elseif curStep == 895 then
		doTweenColor('dad', 'dadGroup', 'FEC1FD', 0.001, 'linear')
	    elseif curStep == 951 then
			triggerEvent('Play Animation', 'si', 'Dad')
		end
	end