function onCreate()

-- gatosexo 1era fase

makeLuaSprite('mol','cc/mallnew/floor',-300, -50)
addLuaSprite('mol')
scaleObject('mol', 1.9, 1.9)
setScrollFactor('mol', 0.80, 0.90);
if not lowQuality then
makeAnimatedLuaSprite('ST','cc/static/static1',0,0)
addAnimationByPrefix('ST', 'static', 'vine-boom', 24, true);
setObjectCamera('ST','other')
setProperty('ST.alpha',0)
setProperty('ST.antialiasing',false)
scaleObject('ST',2.5, 2.5)
addLuaSprite('ST')
end

-- gatosexo 2da fase

makeLuaSprite('fg','cc/taf/mall-destroyed/fg',-1703, 24)
scaleObject('fg', 1.6, 1.6)
setScrollFactor('fg', 0.95, 0.95);
setProperty('fg.alpha',0.0001)
if not lowQuality then
makeLuaSprite('wa','cc/taf/mall-destroyed/wall',-1345, 830)
addLuaSprite('wa', true)
scaleObject('wa', 1.4, 1.4)
setScrollFactor('wa', 1.10, 1.10);
setProperty('wa.alpha',0.0001)
end
makeAnimatedLuaSprite('nubes','cc/taf/mall-destroyed/TAF_Clouds',-1125,-335)
addAnimationByPrefix('nubes', 'loop', 'Animation', 24, true);
setScrollFactor('nubes', 0.60, 0.70);
setProperty('nubes.alpha',0.0001)
scaleObject('nubes',3.4, 3.4)
if not lowQuality then
makeAnimatedLuaSprite('putas','cc/taf/cartoon_putas', -1425, 1610)
addAnimationByPrefix('putas', 'putas', 'bg putas1', 12, true);
addLuaSprite('putas', true);
setScrollFactor('putas', 1.15, 1.15);
setProperty('putas.alpha',0.0001)
scaleObject('putas',1.9, 1.9)

makeAnimatedLuaSprite('putas2','cc/taf/cartoon_putas', -1010, 1510)
addAnimationByPrefix('putas2', 'putas2', 'bg putas2', 12, true);
addLuaSprite('putas2', true);
setScrollFactor('putas2', 1.15, 1.15);
setProperty('putas2.alpha',0.0001)
scaleObject('putas2',1.9, 1.9)
end
makeLuaSprite('bg','cc/taf/mall-destroyed/bg',-1433, -224)
scaleObject('bg', 2.3, 2.3)
setScrollFactor('bg', 0.95, 0.95);
setProperty('bg.alpha',0)
if not lowQuality then
    makeLuaSprite('finalbg','cc/taf/xdd2',-50, 30)
    scaleObject('finalbg', 2.1, 2.1)
    setScrollFactor('finalbg', 0.80, 0.80);
    setProperty('finalbg.antialiasing',false)
    setProperty('finalbg.visible',false)
makeAnimatedLuaSprite('stbg','cc/taf/static + redacted',-1433,-224)
addAnimationByPrefix('stbg', 'loop', 'estatica pal fondo', 12, true);
scaleObject('stbg', 4.7, 4.7)
setScrollFactor('stbg', 0.60, 0.70);
setProperty('stbg.alpha',0.0001)
setBlendMode('stbg', 'add')
setProperty('stbg.antialiasing',false)
end

addLuaSprite('bg', false);
addLuaSprite('nubes', false);
addLuaSprite('finalbg', false);
addLuaSprite('stbg', false);
addLuaSprite('fg', false);
end
function onStepHit()
if curStep == 288 then
setProperty('duracion.alpha', 1)
setProperty('dadGroup.x', -1140)
setProperty('boyfriendGroup.x', -490)
removeLuaSprite('mol', true)
setProperty('fg.alpha',1)
setProperty('wa.alpha',1)
setProperty('nubes.alpha',1)
setProperty('putas.alpha',1)
setProperty('putas2.alpha',1)
setProperty('bg.alpha',1)
doTweenColor('bfred', 'boyfriendGroup', 'FF9E9E', 0.1, 'linear');
doTweenColor('catred', 'dadGroup', 'FF9E9E', 0.1, 'linear');
doTweenColor('fgred', 'fg', 'FF9E9E', 0.1, 'linear');
doTweenColor('wallred', 'wall', 'FF9E9E', 0.1, 'linear');
function opponentNoteHit(id,data,type,sus)
triggerEvent('Screen Shake','0.3, 0.011','0.3, 0.004')
end
elseif curStep == 790 then
doTweenY('put', 'putas', 710, 2, 'sineInOut');
doTweenY('puta', 'putas2', 610, 2, 'sineInOut');
elseif curStep == 1056 then
setProperty('stbg.alpha',1)
function opponentNoteHit(id,data,type,sus)
triggerEvent('Screen Shake','0.3, 0.016','0.3, 0.006')
end
elseif curStep == 1568 then
    makeAnimatedLuaSprite('estaticaperro','cc/taf/estaticauwu',0,0)
addAnimationByPrefix('estaticaperro', 'loop', 'rojo', 24, true);
scaleObject('estaticaperro', 13, 8)
setProperty('estaticaperro.antialiasing',false)
setObjectCamera('estaticaperro','other')
addLuaSprite('estaticaperro', true);
elseif curStep == 1584 then
setProperty('dadGroup.x', 60)
setProperty('boyfriendGroup.x', 710)
setTimeBarColors('FFFFFF', '')
removeLuaSprite('estaticaperro', true)
removeLuaSprite('fg', true)
removeLuaSprite('wa', true)
removeLuaSprite('nubes', true)
removeLuaSprite('bg', true)
removeLuaSprite('putas', true)
removeLuaSprite('putas2', true)
setProperty('stbg.alpha',0)
function opponentNoteHit(id,data,type,sus)
triggerEvent('Screen Shake','0, 0','0, 0')
end
doTweenColor('bfred', 'boyfriendGroup', 'FFFFFF', 0.1, 'linear');
doTweenColor('catred', 'dadGroup', 'FFFFFF', 0.1, 'linear');
makeLuaSprite('perronegro','cc/taf/cdbg',230,-60)
scaleObject('perronegro', 2.45, 2.3)
setScrollFactor('perronegro', 0.90, 0.90);
addLuaSprite('perronegro', false);
elseif curStep == 1856 then
doTweenColor('bfred', 'boyfriendGroup', 'FF6666', 0.1, 'linear');
doTweenColor('catred', 'dadGroup', 'FF6666', 0.1, 'linear');
doTweenColor('fgred', 'perronegro', 'FF6666', 0.1, 'linear');
elseif curStep == 2688 then
doTweenAlpha('chau', 'camGame', 0.000001, 1.5, 'linear');
doTweenAlpha('chauHud', 'camHUD', 0, 1.5, 'linear');
elseif curStep == 2720 then
    makeAnimatedLuaSprite('aaa','cc/taf/cbf_jumpscar_e', -330, -190)
    addAnimationByPrefix('aaa', 'akhemiedo', 'so scary', 24, false);
    scaleObject('aaa', 2.4, 2.4)
    setProperty('aaa.alpha', 0.000001)
    setObjectCamera('aaa','other')
    setProperty('finalbg.visible',true)
    if not lowQuality then
    makeLuaSprite('final','cc/taf/xdd',-70, -8)
    scaleObject('final', 2.55, 2.55)
    setScrollFactor('final', 0.95, 0.95);
    end
    if lowQuality then
    makeLuaSprite('final-low_end','cc/taf/xddlowend',-70, -8)
    scaleObject('final-low_end', 2.55, 2.55)
    setScrollFactor('final-low_end', 0.95, 0.95);
    end
    makeLuaSprite('viejo','cc/taf/viejo',-430, -107)
    scaleObject('viejo', 3.3, 3)
    setScrollFactor('viejo', 1, 1);
    setProperty('viejo.visible',false)
    
    addLuaSprite('final', false);
    addLuaSprite('final-low_end', false);
    addLuaSprite('viejo', false);
    addLuaSprite('aaa', false);
elseif curStep == 2800 then -- cartun novio (bets parte)
    playAnim('aaa', 'akhemiedo', true)
    setProperty('aaa.alpha', 1)
elseif curStep == 2816 then
setTimeBarColors('282930', '')
setProperty('camHUD.alpha',1)
setProperty('camGame.alpha',1)
removeLuaSprite('perronegro', true)
doTweenColor('bfred', 'boyfriendGroup', 'E35252', 0.1, 'linear');
doTweenColor('catred', 'dadGroup', 'E35252', 0.1, 'linear');
doTweenColor('gfred', 'gfGroup', 'E35252', 0.1, 'linear');
doTweenColor('finalered', 'final', 'CFB3B3', 0.1, 'linear');
if lowQuality then
doTweenColor('finalered', 'final-low_end', 'CFB3B3', 0.1, 'linear');
end
setProperty('final.visible',true)
setProperty('final-low_end.visible',true)
setProperty('finalbg.visible',true)
function opponentNoteHit()
health = getProperty('health')
if getProperty('health') > 0.25 then
setProperty('health', health- 0.02);
end
end
elseif curStep == 2820 then
removeLuaSprite('aaa', true)
elseif curStep == 3328 then
setProperty('duracion.alpha', 0)
doTweenColor('bfred', 'boyfriendGroup', 'FFFFFF', 0.1, 'linear');
doTweenColor('catred', 'dadGroup', 'FFFFFF', 0.1, 'linear');
doTweenColor('gfred', 'gfGroup', 'FFFFFF', 0.1, 'linear');
setProperty('final.visible',false)
setProperty('final-low_end.visible',false)
setProperty('finalbg.visible',false)
setProperty('viejo.visible',true)
setProperty('healthBar.alpha', 0)
setProperty('iconP1.alpha', 0)
setProperty('iconP2.alpha', 0)
setProperty('scoreTxt.alpha', 0)
setProperty('timeBarBG.visible', false)
setProperty('timeBar.visible', false)
setProperty('timeTxt.visible', false)
elseif curStep == 3584 then
setObjectCamera('stbg', 'hud')
setProperty("stbg.x", -180)
setProperty("stbg.y", -110)
doTweenAlpha('stbg', 'stbg', 0.3, 4, 'easeIn');
elseif curStep == 3648 then
setProperty('duracion.alpha', 1)
setProperty('healthBar.alpha', 1)
setProperty('iconP1.alpha', 1)
setProperty('iconP2.alpha', 1)
setProperty('scoreTxt.alpha', 1)
setProperty('timeBarBG.visible', true)
setProperty('timeBar.visible', true)
setProperty('timeTxt.visible', true)
setObjectCamera('stbg', 'game')
doTweenColor('bfred', 'boyfriendGroup', 'E35252', 0.1, 'linear');
doTweenColor('catred', 'dadGroup', 'E35252', 0.1, 'linear');
doTweenColor('gfred', 'gfGroup', 'E35252', 0.1, 'linear');
setProperty('final.visible',true)
setProperty('finalbg.visible',true)
setProperty('final-low_end.visible',true)
setProperty('stbg.alpha',1)
removeLuaSprite('viejo', true)
setProperty("stbg.x", -210)
setProperty("stbg.y", -80)
elseif curStep == 3904 then
removeLuaSprite('stbg', true)
elseif curStep == 3952 then
setProperty('camGame.visible',false)
setProperty('camHUD.visible',false)
end
end
-- zJosiz