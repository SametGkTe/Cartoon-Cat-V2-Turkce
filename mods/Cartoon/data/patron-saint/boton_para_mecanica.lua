function onCreate()

        makeAnimatedLuaSprite('s', 'spacebutt', 1120, 348);
        addAnimationByPrefix('s', 's', 's', 24, false);
	addAnimationByPrefix('s', 'sPress', 'sPressed', 16, false);
	addLuaSprite('s', true);
	scaleObject('s', 1.2, 1.2)
	setObjectCamera('s', 'other')
	setProperty('s.alpha', 0.000001)

end

function onUpdate()
	if getMouseX('hud') > getProperty('s.x') and getMouseY('hud') > getProperty('s.y') and getMouseX('hud') < getProperty('s.x') 
	+ getProperty('s.width') and getMouseY('hud') < getProperty('s.y') + getProperty('s.height') and mouseClicked('left') or keyboardJustPressed('SPACE') then
			objectPlayAnimation('s', 'sPress', false);
end
end