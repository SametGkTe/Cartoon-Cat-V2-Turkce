function onCreate()
	makeLuaSprite('bg1', 'cc/wi/bg1', -595, 0);
	scaleObject('bg1', 5.3, 5.3)
	addLuaSprite('bg1', false);
	
	makeLuaSprite('sol-africano', 'cc/wi/sol-africano', -55, -140);
	scaleObject('sol-africano', 5.2, 5.2)
	addLuaSprite('sol-africano', false);
	setProperty('sol-africano.alpha',0.00001)

	makeLuaSprite('bg2', 'cc/wi/bg2', -360, -370);
	scaleObject('bg2', 3.7, 3.7)
	addLuaSprite('bg2', false);

	makeAnimatedLuaSprite('fuego','cc/wi/fuego-estadounidense', -450, -260)
    addAnimationByPrefix('fuego', 'idle', 'fuego', 12, true);
    scaleObject('fuego',4.5, 4.5)
    addLuaSprite('fuego', false)
	setProperty('fuego.alpha',0)

	makeLuaSprite('plataformas', 'cc/wi/bg3', 490, 915);
	scaleObject('plataformas', 3.7, 3.3)
	addLuaSprite('plataformas', false);

	makeLuaSprite('transicion', 'cc/wi/clouds', 0, 780);
	scaleObject('transicion', 3.1, 3.6)
	addLuaSprite('transicion', false);
	setObjectCamera('transicion','hud')
	setProperty('transicion.antialiasing',false)

	makeLuaSprite('bflashh', '', 0, 0);
        makeGraphic('bflashh',680,340,'000000')
        addLuaSprite('bflashh', false);
        setObjectCamera('bflashh','other')
        setProperty('bflashh.scale.x',3)
        setProperty('bflashh.scale.y',3.4)
        setObjectOrder('bflashh', 0);
        setProperty('bflashh.antialiasing',false)

	makeAnimatedLuaSprite('grr', 'cc/wi/grain', 0, 0); 
    addAnimationByPrefix('grr', 'idle', 'grain', 26, true); 
    addLuaSprite('grr', false);
    setObjectCamera('grr', 'other');
    scaleObject('grr',2.6, 2.6)
	setProperty('grr.antialiasing',false)
if not lowQuality then
		makeAnimatedLuaSprite('letrero','WIsign', 20, 325)
		addAnimationByPrefix('letrero', 'intro', 'manopaja', 20, false);
		addLuaSprite('letrero', true);
		scaleObject('letrero',1.7, 1.7)
		setObjectCamera('letrero', 'other')
		setProperty('letrero.alpha',0)
end
end
function onStepHit()
		if curStep == 20 then
		removeLuaSprite('letrero', true)
		elseif curStep == 55 then
	doTweenAlpha('notas', 'camHUD',  1, 0.5, 'linear')
elseif curStep == 70 then
	removeLuaSprite('bflashh', true)
	removeLuaSprite('TopBar', true)
	removeLuaSprite('BottomBar', true)
elseif curStep == 416 then
	doTweenY('bg1', 'bg1', -250, 1, 'sineOut')
	doTweenY('bg2', 'bg2',  150, 1, 'sineOut')
elseif curStep == 417 then
	doTweenY('transicion', 'transicion',  -370, 1.2, 'sineOut')
elseif curStep == 424 then
	removeLuaSprite('transicion', true)
	setProperty('fuego.alpha',1)
	setProperty('bg1.alpha',0)
	setProperty('bg2.alpha',0)
	setProperty('sol-africano.alpha',1)
elseif curStep == 544 then
	setProperty('camGame.alpha',0)
	setProperty('camHUD.alpha',0)
	setProperty('fuego.alpha',0)
	setProperty('bg1.alpha',1)
	setProperty('bg2.alpha',1)
	removeLuaSprite('sol-africano', true)
	setProperty('bg1.y',0)
	setProperty('bg2.y',-370)
elseif curStep == 549 then
	doTweenAlpha('camHUD', 'camHUD',  1, 1, 'linear')
elseif curStep == 552 then
	doTweenAlpha('bflasz', 'camGame',  1, 1, 'linear')
elseif curStep == 888 then
	setProperty('fuego.alpha',1)
elseif curStep == 1034 then
	doTweenAlpha('final', 'bflash',  1, 1.5, 'linear')
	if lowQuality then
		doTweenAlpha('final-lowend', 'camGame',  0, 1.5, 'linear')
	end
end
end
function onCreatePost()
	setProperty('camHUD.alpha',0.0001)
	removeLuaSprite('static', true)
	setObjectOrder('vignetteog',3)
	setObjectOrder('transicion',0)
	setObjectOrder('grr',23)
	setObjectCamera('bflash','other')
	setProperty('comprobacionperro.x',560)
	setProperty('comprobacionperro.y',7)
end
function onSongStart()
	doTweenAlpha('bflashz', 'bflashh',  0, 10, 'linear')
		playAnim('letrero', 'intro', true)
		setProperty('letrero.alpha',1)
end