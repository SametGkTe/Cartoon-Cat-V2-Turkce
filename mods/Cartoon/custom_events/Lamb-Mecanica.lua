function onCreate() -- hace mas de 7 meses que nisiquiera intente codear mecanicas :moyai:
makeAnimatedLuaSprite('espazio','Instructions_Space', -40, -100)
    addAnimationByPrefix('espazio', 'apreta wbn', 'Instructions Space Idle', 24, true);
    addLuaSprite('espazio', true)
	setProperty('espazio.alpha',0.00001)
	scaleObject('espazio',1.5, 1.5)
	setObjectCamera('espazio', 'hud')

	makeAnimatedLuaSprite('gfmeca','characters/gf_standing_hide_and_seek', 660, 60)
    addAnimationByPrefix('gfmeca', 'idle', 'gf idle mechanic', 18, true);
    addLuaSprite('gfmeca', false)
	setProperty('gfmeca.alpha',0)
	scaleObject('gfmeca',2.38, 2.38)

	makeLuaSprite('r', '', 0, 0);
        makeGraphic('r',680,340,'FF0000')
        addLuaSprite('r', false);
        setObjectCamera('r','hud')
        setLuaSpriteScrollFactor('r',0,0)
        setProperty('r.scale.x',3)
        setProperty('r.scale.y',3.4)
        setObjectOrder('r', 0);
        setProperty('r.alpha',0.000001)
        setProperty('r.antialiasing',false)
end
function onEvent(n,v1,v2)
if n == "Lamb-Mecanica" then
	doTweenAlpha('espacio', 'espazio', 1, 0.2, 'linear')
	doTweenAlpha('botonappear', 's', 0.4, 0.2, 'linear')
	runTimer('espacio w', 2.7)
	runTimer('grito w', 0.7)
    if not botPlay then
	runTimer('muere w', 1)
	end
end
end
function onUpdate(elapsed)
	if getMouseX('hud') > getProperty('s.x') and getMouseY('hud') > getProperty('s.y') and getMouseX('hud') < getProperty('s.x') 
	+ getProperty('s.width') and getMouseY('hud') < getProperty('s.y') + getProperty('s.height') and mouseClicked('left') or keyboardJustPressed('SPACE') then
		cancelTimer('muere w')
	end
end
function onTimerCompleted(tag, loops, loopsLeft)
	if tag == 'espacio w' then
		doTweenAlpha('espacio', 'espazio', 0, 0.4, 'linear')
		doTweenAlpha('botonappear', 's', 0, 0.2, 'linear')
		triggerEvent('Change Character', 'BF', 'bf-mechanic-lamb')
		setProperty('gfmeca.alpha',1)
		setProperty('gfGroup.alpha',0.001)
		runTimer('escudo timer', 5)
		setProperty('r.alpha',1)
		doTweenAlpha('flash', 'r', 0, 0.4, 'linear')
	end
	if tag == 'grito w' then
		triggerEvent('Play Animation', 'shine', 'Dad')
		playSound('lamb_sound', 0.99)
	end
    if tag == 'muere w' then
        setProperty('health', 0)
	end
	if tag == 'escudo timer' then
		triggerEvent('Change Character', 'BF', 'bf-lamb')
		setProperty('gfmeca.alpha',0)
		setProperty('gfGroup.alpha',1)
		setProperty('r.alpha',1)
		doTweenAlpha('flash', 'r', 0, 0.4, 'linear')
	end
end
-- code por zJosiz, hecho en 9 minutos xD