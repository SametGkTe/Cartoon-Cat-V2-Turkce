function onCreate()
	makeLuaSprite('piggy book 23','cc/pig/bg',-700, -153)
	addLuaSprite('piggy book 23')
	scaleObject('piggy book 23', 2.2, 2.2)
	setLuaSpriteScrollFactor('piggy book 23', 0.9, 0.9)

	makeLuaSprite('luz','cc/pig/ghost_pig_light',-150, -150)
	addLuaSprite('luz', true)
	scaleObject('luz', 2.2, 2.2)
	runTimer('luz timer', 3)
	if not lowQuality then
	makeLuaSprite('fg','cc/pig/fence',-640, 755)
	addLuaSprite('fg', true)
	scaleObject('fg', 2.9, 2.2)
	setLuaSpriteScrollFactor('fg', 1.2, 1.2)
	end
end
function onTimerCompleted(tag, loops, loopsLeft)
    if tag == 'luz timer' then
		setProperty('luz.alpha', 0.1)
		runTimer('luz2', 0.1)
	end
	if tag == 'luz2' then
		setProperty('luz.alpha', 1)
		runTimer('luz3', 2)
	end
	if tag == 'luz3' then
		setProperty('luz.alpha', 0.1)
		runTimer('luz4', 0.1)
	end
	if tag == 'luz4' then
		setProperty('luz.alpha', 1)
		runTimer('luz5', 3)
	end
	if tag == 'luz5' then
		setProperty('luz.alpha', 0.1)
		runTimer('luz6', 0.1)
	end
	if tag == 'luz6' then
		setProperty('luz.alpha', 1)
		runTimer('luz timer', 4)
	end
end
function onUpdatePost()
	P1Mult = getProperty('healthBar.x') + ((getProperty('healthBar.width') *        getProperty('healthBar.percent') * 0.01) + (150 * getProperty('iconP1.scale.x') - 150) / 2 - 26)
   
	P2Mult = getProperty('healthBar.x') + ((getProperty('healthBar.width') * getProperty('healthBar.percent') * 0.01) - (150 * getProperty('iconP2.scale.x')) / 2 - 26 * 2)
   
	setProperty('iconP1.x',P1Mult - 110)
   
	setProperty('iconP1.origin.x',240)
   
	setProperty('iconP1.flipX',true)
   
	setProperty('iconP2.x',P2Mult + 110)
   
	setProperty('iconP2.origin.x',-100)
   
	setProperty('iconP2.flipX',true)
   
	setProperty('healthBar.flipX',true)

	if version >= '0.7' then
        setProperty('iconP1.x', getProperty('iconP1.x')+335)
        setProperty('iconP2.x', getProperty('iconP2.x')+330)
	end
	if not middlescroll then
	noteTweenX('Movement X 0', 0, defaultPlayerStrumX0, 0.00000000001)
	noteTweenX('Movement X 1', 1, defaultPlayerStrumX1, 0.00000000001)
	noteTweenX('Movement X 2', 2, defaultPlayerStrumX2, 0.00000000001)
	noteTweenX('Movement X 3', 3, defaultPlayerStrumX3, 0.00000000001)

	noteTweenX('Movement X 4', 4, defaultOpponentStrumX0, 0.00000000001)
	noteTweenX('Movement X 5', 5, defaultOpponentStrumX1, 0.00000000001)
	noteTweenX('Movement X 6', 6, defaultOpponentStrumX2, 0.00000000001)
	noteTweenX('Movement X 7', 7, defaultOpponentStrumX3  , 0.00000000001)
end
end
function onStepHit()
	if curStep == 1296 then
	setProperty('camGame.alpha', 0)
	end
end