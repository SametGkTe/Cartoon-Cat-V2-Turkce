function onCreate()
	makeLuaSprite('negro', '', 280, 100);
    makeGraphic('negro',680,340,'ffffff')
    addLuaSprite('negro', false);
    setLuaSpriteScrollFactor('negro',0,0)
    setProperty('negro.scale.x',2.2)
    setProperty('negro.scale.y',2)
	setProperty('negro.antialiasing', false)

	makeLuaSprite('pizo','cc/282_sin_titulo_20230331201550', -80, 137)
addLuaSprite('pizo', false)
scaleObject('pizo', 2.3, 2.3)
setLuaSpriteScrollFactor('pizo',0,1)
setProperty('pizo.antialiasing', false)

makeAnimatedLuaSprite('fuego','cc/fire', -80, 375)
    addAnimationByPrefix('fuego', 'idle', 'Fire Idle', 24, true);
    scaleObject('fuego',3.3, 1.8)
    addLuaSprite('fuego', false)
	setProperty('fuego.alpha',0.00001)
	setLuaSpriteScrollFactor('fuego',0,1)
	setProperty('fuego.antialiasing', false)

	makeLuaSprite('pizo2', '', 260, 773);
    makeGraphic('pizo2',683,100,'989898')
    addLuaSprite('pizo2', false);
    setLuaSpriteScrollFactor('pizo2',0,1)
    setProperty('pizo2.scale.x',2.2)
    setProperty('pizo2.scale.y',2)
	setProperty('pizo2.alpha',0.00001)
	setProperty('pizo2.antialiasing', false)

	makeAnimatedLuaSprite('piernas','cc/patas', 280, 110)
    addAnimationByPrefix('piernas', 'correr', 'patas', 12, true);
    addLuaSprite('piernas', false)
	setProperty('piernas.alpha',0)
	scaleObject('piernas',2, 2)
	setProperty('piernas.antialiasing', false)

	makeLuaSprite('pared','cc/epicccexebg', -150, 0)
addLuaSprite('pared', false)
scaleObject('pared', 2.5, 2.5)
setProperty('pared.antialiasing',false)
setProperty('pared.alpha',0)

makeLuaSprite('I AM THE REAL GOD','cc/jumpscare', -0, 0)
addLuaSprite('I AM THE REAL GOD', false)
scaleObject('I AM THE REAL GOD', 2, 2)
setObjectCamera('I AM THE REAL GOD', 'hud')
setProperty('I AM THE REAL GOD.antialiasing',false)
setProperty('I AM THE REAL GOD.alpha',0)

makeLuaSprite('flipo','cc/logoclip', 0, 600)
addLuaSprite('flipo', false)
setProperty('flipo.antialiasing',false)
setObjectCamera('flipo', 'other')

	makeAnimatedLuaSprite('letrero','Cursed_letrero', 0, 290)
    addAnimationByPrefix('letrero', 'hola', 'hola', 12, false);
    scaleObject('letrero', 1.7, 1.7)
    addLuaSprite('letrero', true)
	setObjectCamera('letrero', 'other')
	setProperty('letrero.alpha', 0.000001)
	setProperty('letrero.antialiasing', false)
end
function onSongStart()
	playAnim('letrero', 'hola', true)
	setProperty('letrero.alpha', 1)
end
function onCreatePost()
	removeLuaSprite('noteCombo', true)
	removeLuaSprite('vignetteog', true)
	removeLuaSprite('static', true)
end
function onStepHit()
	if curStep == 40 then
		removeLuaSprite('letrero', true)
elseif curStep == 272 then
	setProperty('camGame.alpha', 0)
	elseif curStep == 304 then
		setProperty('camGame.alpha', 1)
		setProperty('piernas.alpha',1)
		setProperty('fuego.alpha',1)
		setProperty('pizo2.alpha',1)
		doTweenColor('c', 'negro', '4E4E4E', 0.1, 'linear')
		removeLuaSprite('pizo', true)
	elseif curStep == 949 then
		setProperty('camGame.alpha', 0)
		setProperty('pared.alpha', 1)
		removeLuaSprite('piernas', true)
		removeLuaSprite('fuego', true)
		removeLuaSprite('pizo2', true)
	elseif curStep == 992 then
		doTweenAlpha('c', 'camGame', 1, 4, 'linear')
	elseif curStep == 1296 then
		setProperty('I AM THE REAL GOD.alpha',1)
	elseif curStep == 1312 then
		removeLuaSprite('I AM THE REAL GOD',true)
	end
end