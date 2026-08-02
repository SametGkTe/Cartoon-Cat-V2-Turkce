function onCreate()
makeLuaSprite('room','cc/roomnew/bg', -480, 17)
addLuaSprite('room', false)
scaleObject('room', 1.8, 1.8)
setScrollFactor('room', 0.85, 0.85);

makeLuaSprite('bflash', '', 0, 0);
makeGraphic('bflash',680,340,'000000')
addLuaSprite('bflash', false);
setObjectCamera('bflash','other')
setProperty('bflash.scale.x',3)
setProperty('bflash.scale.y',3.4)
setObjectOrder('bflash', 0);
setProperty('bflash.alpha', 0);

makeAnimatedLuaSprite('putonegro','characters/como_tan_muchacho', 75, 160)
addAnimationByPrefix('putonegro', 'idle', 'rrgg pene', 24, true);
setProperty('putonegro.alpha',0)
scaleObject('putonegro',1.31, 1.31)
addLuaSprite('putonegro', false)
end
function onStepHit()
if curStep == 589 then
doTweenAlpha('negro', 'bflash', 1, 0.7, 'linear');
noteTweenAlpha('noteFadeIn0', 0, 0, 1.5, 'quadInOut')
noteTweenAlpha('noteFadeIn1', 1, 0, 1.5, 'quadInOut')
noteTweenAlpha('noteFadeIn2', 2, 0, 1.5, 'quadInOut')
noteTweenAlpha('noteFadeIn3', 3, 0, 1.5, 'quadInOut')
noteTweenAlpha('noteFadeIn4', 4, 0, 1.5, 'quadInOut')
noteTweenAlpha('noteFadeIn5', 5, 0, 1.5, 'quadInOut')
noteTweenAlpha('noteFadeIn6', 6, 0, 1.5, 'quadInOut')
noteTweenAlpha('noteFadeIn7', 7, 0, 1.5, 'quadInOut')
doTweenAlpha('healthBar', 'healthBar', 0, 1.5, 'linear');
doTweenAlpha('CCBar', 'CCBar', 0, 1.5, 'linear');
doTweenAlpha('iconP1', 'iconP1', 0, 1.5, 'linear');
doTweenAlpha('iconP2', 'iconP2', 0, 1.5, 'linear');
elseif curStep == 635 then
removeLuaText('liri', true)
setProperty('bflash.alpha',0)
setProperty('putonegro.alpha',1)
setProperty('dadGroup.alpha',0)
triggerEvent('Change Character', 'dad', 'miau')
elseif curStep == 636 then
noteTweenAlpha('noteFadeIn4', 4, 1, 1, 'quadInOut')
noteTweenAlpha('noteFadeIn5', 5, 1, 1, 'quadInOut')
noteTweenAlpha('noteFadeIn6', 6, 1, 1, 'quadInOut')
noteTweenAlpha('noteFadeIn7', 7, 1, 1, 'quadInOut')
doTweenAlpha('healthBar', 'healthBar', 1, 1, 'linear');
doTweenAlpha('CCBar', 'CCBar', 1, 1, 'linear');
doTweenAlpha('iconP1', 'iconP1', 1, 1, 'linear');
doTweenAlpha('iconP2', 'iconP2', 1, 1, 'linear');
elseif curStep == 924 then
doTweenAlpha('bflash', 'bflash', 1, 27, 'linear');
end
end