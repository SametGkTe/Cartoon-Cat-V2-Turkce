local barAmount = 0
local burst = false

function onCreate() -- Hecho por Lio, yo le mejore cosas xd
	makeAnimatedLuaSprite('x','XXX', 40, -25)
    addAnimationByPrefix('x', 'apreta wbn', 'idle', 24, true);
    addLuaSprite('x', true)
	setProperty('x.alpha',0.00001)
	scaleObject('x',1.9, 1.9)
	setObjectCamera('x', 'hud')

	makeLuaSprite('white', 'white', 1165,115)
	setObjectCamera('white', 'hud')
	addLuaSprite('white')
	scaleObject('white', 2.04, 2)
if not botPlay then
	makeLuaSprite('redbar', 'redbar', 1195, 549)
	makeGraphic('redbar', 18, 1, 'FF000D')
	setObjectCamera('redbar', 'hud')
	setProperty('redbar.origin.y', 1)
	addLuaSprite('redbar')
end
	makeLuaSprite('barNormal', 'healthBarLeovincible', 1140, 90)
	setObjectCamera('barNormal', 'hud')
	addLuaSprite('barNormal', true)
end

function onUpdate()
	if not botPlay then
	if barAmount >= 230 then
	        triggerEvent('Change Character','bf','bf_eyes');
	end	
	if barAmount >= 399 then
		death = true
	end
	if death then
 		setProperty('health', 0);

  	end
	if barAmount<0 then
  		barAmount=0
	end
	 if barAmount<399 and getMouseX('hud') > getProperty('s.x') and getMouseY('hud') > getProperty('s.y') and getMouseX('hud') < getProperty('s.x') 
	 + getProperty('s.width') and getMouseY('hud') < getProperty('s.y') + getProperty('s.height') and mouseClicked('left') or keyboardJustPressed('X') then
   	        burst = true
    end
	if burst == true then
		    if barAmount ~= 0 then
	        triggerEvent('Change Character','bf','bf_leovincible');
        	barAmount= barAmount - 0.80
			setProperty('redbar.scale.y', - barAmount)
		    setProperty('redbar.color', getColorFromHex('FF000D'))
	    else
        burst = false
			end		
		end
end
end
function onSongStart()
	runTimer('barra', 1)
	runTimer('XXXXXXXXXXXX', 0.0001)
end
	function onTimerCompleted(tag, loops, loopsLeft)
		if tag == 'XXXXXXXXXXXX' then
			doTweenAlpha('indicador', 'x', 1, 0.5)
			runTimer('XXXXXXXXXXX', 6)
		end
		if tag == 'XXXXXXXXXXX' then
			doTweenAlpha('indicador', 'x', 0, 0.5)
			runTimer('XXXXXXXXXX', 1)
		end
		if tag == 'XXXXXXXXXX' then
removeLuaSprite('x', true)
		end
		if tag == 'barra' then
			runTimer('barra', 0.1)
			if burst == false then
				barAmount= barAmount + 3
				setProperty('redbar.scale.y', barAmount)
				end	
				if barAmount > 399 then
						  barAmount=399
		end
	end
end
function onStepHit() -- lo tenia que poner un poquito mas hard JJASJAKJA
	if curStep == 1505 then
		function onTimerCompleted(tag, loops, loopsLeft)
			if tag == 'barra' then
				runTimer('barra', 0.04)
				if burst == false then
					barAmount= barAmount + 8
					setProperty('redbar.scale.y', barAmount)
					end	
					if barAmount > 399 then
							  barAmount=399
			end
		end
	end
	end
end