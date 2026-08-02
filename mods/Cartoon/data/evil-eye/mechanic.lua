function onCreate()
        makeAnimatedLuaSprite('s', 'x', 10, 498);
        addAnimationByPrefix('s', 's', 's', 24, false);
	addAnimationByPrefix('s', 'sPress', 'sPressed', 16, false);
	addLuaSprite('s', false);
	scaleObject('s', 1.2, 1.2)
	setObjectCamera('s', 'other')
	setProperty('s.alpha', 0.00001)
runTimer('pc', 7)
end
function onUpdate()
	if getMouseX('hud') > getProperty('s.x') and getMouseY('hud') > getProperty('s.y') and getMouseX('hud') < getProperty('s.x') 
	+ getProperty('s.width') and getMouseY('hud') < getProperty('s.y') + getProperty('s.height') and mouseClicked('left') or keyboardJustPressed('X') then
			objectPlayAnimation('s', 'sPress', false);
	end
		if getMouseX('hud') > getProperty('s.x') and getMouseY('hud') > getProperty('s.y') and getMouseX('hud') < getProperty('s.x') 
	+ getProperty('s.width') and getMouseY('hud') < getProperty('s.y') + getProperty('s.height') and mouseClicked('left') then
		runTimer('pc', 5)
		setProperty('s.alpha', 0.4)
end
end
function onTimerCompleted(tag, loops, loopsLeft)
	if tag == 'pc' then
		doTweenAlpha('s', 's', 0, 2, 'linear')
	end
end
function onSongStart()
	doTweenAlpha('s', 's', 0.6, 2, 'linear')
end