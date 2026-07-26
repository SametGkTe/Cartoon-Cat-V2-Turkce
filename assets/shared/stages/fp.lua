local healthflipped = true;
function onCreate()
	makeLuaSprite('bg1','cc/fp/bg1', -20, -5)
	addLuaSprite('bg1')
	scaleObject('bg1', 4.7, 4.7)
	
	makeLuaSprite('bg2','cc/fp/bg2', 2, 1)
addLuaSprite('bg2')
scaleObject('bg2', 3.34, 3.34)

makeLuaSprite('light','cc/fp/light', -35, -45)
addLuaSprite('light', true)
scaleObject('light', 4.9, 5.2)
setBlendMode('light', 'add')

	makeLuaSprite('hola','hola', -270, 250)
addLuaSprite('hola', true)
scaleObject('hola', 2, 1.7)
setObjectCamera('hola', 'other')
setProperty('hola.antialiasing', false)

makeLuaText('sta', '', -1, 10, 262)
setTextSize('sta', 26)
setObjectCamera('sta', 'other')
addLuaText('sta', true)
setTextFont('sta', 'impact.ttf')
setTextBorder('sta', 1.6, '000000')

makeLuaText('a', '', -1, 10, 325)
setTextSize('a', 26)
setObjectCamera('a', 'other')
addLuaText('a', true)
setTextFont('a', 'impact.ttf')
setTextBorder('a', 1.6, '000000')
end
function goodNoteHit(id,data,type,sus)
	triggerEvent('Screen Shake','0.1, 0.005','0, 0')
	end
	function opponentNoteHit(id,data,type,sus)
		triggerEvent('Screen Shake','0.1, 0.003','0, 0')
		end
function onSongStart()
runTimer('name de la song',0.001)
end
function onCreatePost()
	setObjectOrder('bg1', 0)
	setObjectOrder('boyfriendGroup', 2)
	setObjectOrder('bg2', 3)
end
function onUpdatePost()
	if healthflipped == true then
   
		P1Mult = getProperty('healthBar.x') + ((getProperty('healthBar.width') * getProperty('healthBar.percent') * 0.01) + (150 * getProperty('iconP1.scale.x') - 150) / 2 - 26)

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
end

 if healthflipped == false then

		P1Mult = getProperty('healthBar.x') - ((getProperty('healthBar.width') * getProperty('healthBar.percent') * 0.01) + (150 * getProperty('iconP1.scale.x') - 150) / 2 - 26)

		P2Mult = getProperty('healthBar.x') - ((getProperty('healthBar.width') * getProperty('healthBar.percent') * 0.01) - (150 * getProperty('iconP2.scale.x')) / 2 - 26 * 2)

		setProperty('iconP2.origin.x',0)

		setProperty('iconP2.flipX',false)

		setProperty('iconP1.origin.x',0)

		setProperty('iconP1.flipX',false)

		setProperty('healthBar.flipX',false)
 end
end
function onTimerCompleted(tag, loops, loopsLeft)
    if tag == 'name de la song' then
doTweenX('hola', 'hola', -50, 0.4, 'linear')
runTimer('texto aparece', 0.8)
	end
	if tag == 'texto aparece' then
	setTextString('sta', 'S')
	setTextString('a', 'Di')
	runTimer('texto aparece2', 0.05)
end
if tag == 'texto aparece2' then
	setTextString('sta', 'ST')
	setTextString('a', 'Dist')
	runTimer('texto aparece3', 0.05)
end
if tag == 'texto aparece3' then
	setTextString('sta', 'STA')
	setTextString('a', 'Distant')
	runTimer('texto aparece4', 0.05)
end
if tag == 'texto aparece4' then
	setTextString('a', 'Distant Al')
	runTimer('texto aparece5', 0.05)
end
if tag == 'texto aparece5' then
	setTextString('a', 'Distant Alarm')
	runTimer('chau', 4)
end
if tag == 'chau' then
	setTextString('a', 'Distant Ala')
	runTimer('chau texto', 0.05)
end
if tag == 'chau texto' then
	setTextString('a', 'Distant ')
	runTimer('chau texto2', 0.05)
end
if tag == 'chau texto2' then
	setTextString('a', 'Dista')
	runTimer('chau texto3', 0.05)
end
if tag == 'chau texto3' then
	setTextString('a', 'Dis')
	runTimer('chau texto4', 0.05)
end
if tag == 'chau texto4' then
	setTextString('a', 'D')
	runTimer('chau texto5', 0.05)
end
if tag == 'chau texto5' then
	removeLuaText('a', true)
	runTimer('chau texto6', 0.05)
end
if tag == 'chau texto6' then
	setTextString('sta', 'st')
	runTimer('chau texto7', 0.05)
end
if tag == 'chau texto7' then
	setTextString('sta', 's')
	runTimer('chau texto8', 0.05)
end
if tag == 'chau texto8' then
	removeLuaText('sta', true)
	doTweenX('hola', 'hola', -270, 0.3, 'linear')
	runTimer('chausito', 1)
end
if tag == 'chausito' then
	removeLuaSprite('hola', true)
end
end
function onStepHit()
	if curStep == 768 then 
		healthflipped = false;
		function goodNoteHit(id,data,type,sus)
			triggerEvent('Screen Shake','0, 0','0, 0')
			end
			function opponentNoteHit(id,data,type,sus)
				triggerEvent('Screen Shake','0, 0','0, 0')
				end
		setProperty('camGame.alpha', 0)
		setProperty('healthBar.alpha', 0)
		setProperty('iconP1.alpha', 0)
		setProperty('iconP2.alpha', 0)
		setProperty('scoreCC.alpha', 0)
		setProperty('CCBar.alpha', 0)
		setProperty('CCBar1.alpha', 0)
		doTweenAlpha('camHUD', 'camHUD', 0, 5, 'linear')
	elseif curStep == 1064 then 
		setProperty('camGame.alpha', 1)
		setProperty('healthBar.alpha', 1)
		setProperty('iconP1.alpha', 1)
		setProperty('iconP2.alpha', 1)
		setProperty('scoreCC.alpha', 1)
		setProperty('CCBar.alpha', 1)
		setProperty('CCBar1.alpha', 1)
		doTweenAlpha('camHUD', 'camHUD', 1, 4, 'linear')
		makeLuaSprite('cc','cc/mallnew/floor', 110, 300)
		addLuaSprite('cc')
		scaleObject('cc', 2.15, 2.15)
		setScrollFactor('cc', 0.90, 0.90);
		setObjectOrder('cc', 1)
		setProperty('bg1.visible', false)
		setProperty('bg2.visible', false)
		setProperty('light.visible', false)
		if not middlescroll then
			setPropertyFromGroup('playerStrums', 0, 'x', defaultPlayerStrumX0)
			setPropertyFromGroup('playerStrums', 1, 'x', defaultPlayerStrumX1)
			setPropertyFromGroup('playerStrums', 2, 'x', defaultPlayerStrumX2)
			setPropertyFromGroup('playerStrums', 3, 'x', defaultPlayerStrumX3)
			setPropertyFromGroup('playerStrums', 4, 'x', defaultPlayerStrumX4)
			setPropertyFromGroup('opponentStrums', 0, 'x', defaultOpponentStrumX0)
			setPropertyFromGroup('opponentStrums', 1, 'x', defaultOpponentStrumX1)
			setPropertyFromGroup('opponentStrums', 2, 'x', defaultOpponentStrumX2)
			setPropertyFromGroup('opponentStrums', 3, 'x', defaultOpponentStrumX3)
			setPropertyFromGroup('opponentStrums', 4, 'x', defaultOpponentStrumX4)
		end
	elseif curStep == 1238 then
		setProperty('CCBar.alpha', 1)
		setProperty('CCBar1.alpha', 1)
	elseif curStep == 1449 then 
		doTweenAlpha('camHUD', 'camHUD', 0, 4, 'linear')
		doTweenAlpha('camGame', 'camGame', 0, 4, 'linear')
	elseif curStep == 1580 then 
		setProperty('camGame.alpha', 1)
		setProperty('camHUD.alpha', 1)
		removeLuaSprite('cc', true)
		setProperty('bg1.visible', true)
		setProperty('bg2.visible', true)
		setProperty('light.visible', true)
		function goodNoteHit(id,data,type,sus)
			triggerEvent('Screen Shake','0.1, 0.005','0, 0')
			end
			function opponentNoteHit(id,data,type,sus)
				triggerEvent('Screen Shake','0.1, 0.003','0, 0')
				end
		healthflipped = true;
		if not middlescroll then
			setPropertyFromGroup('playerStrums', 0, 'x', defaultOpponentStrumX0)
			setPropertyFromGroup('playerStrums', 1, 'x', defaultOpponentStrumX1)
			setPropertyFromGroup('playerStrums', 2, 'x', defaultOpponentStrumX2)
			setPropertyFromGroup('playerStrums', 3, 'x', defaultOpponentStrumX3)
			setPropertyFromGroup('playerStrums', 4, 'x', defaultOpponentStrumX4)
			setPropertyFromGroup('opponentStrums', 0, 'x', defaultPlayerStrumX0)
			setPropertyFromGroup('opponentStrums', 1, 'x', defaultPlayerStrumX1)
			setPropertyFromGroup('opponentStrums', 2, 'x', defaultPlayerStrumX2)
			setPropertyFromGroup('opponentStrums', 3, 'x', defaultPlayerStrumX3)
			setPropertyFromGroup('opponentStrums', 4, 'x', defaultPlayerStrumX4)
		end
	end
	end