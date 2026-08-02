function onCreate()
makeAnimatedLuaSprite('letrero','letrero', -420, 315)
addAnimationByPrefix('letrero', 'intro', 'intro', 12, false);
addLuaSprite('letrero', true);
scaleObject('letrero',1.6, 1.6)
setObjectCamera('letrero', 'other')
setProperty('letrero.alpha',0)

makeLuaText('name', 'HIDDEN TRUTHS', 780, 180, 320)
setTextSize('name', 100)
scaleObject('name',0.2, 0.2)
setObjectCamera('name', 'other')
addLuaText('name', true)
setTextFont('name', 'impact.ttf')
setProperty('name.alpha', 0)

makeLuaText('credi', 'BY SyncoStorm', 1080, 150, 350)
setTextSize('credi', 90)
scaleObject('credi',0.2, 0.2)
setObjectCamera('credi', 'other')
addLuaText('credi', true)
setTextFont('credi', 'impact.ttf')
setProperty('credi.alpha', 0)
setTextColor('credi', '973640')
end
function onSongStart()
playAnim('letrero', 'intro', true)
setProperty('letrero.alpha',1)
end
function onStepHit()
if curStep == 6 then
doTweenAlpha('name', 'name', 1, 0.3, 'linear');
elseif curStep == 7 then
doTweenAlpha('credi', 'credi', 1, 0.3, 'linear');
elseif curStep == 30 then
doTweenX('chaoletrero', 'letrero', -820, 0.8, 'backIn');
doTweenX('name', 'name', -230, 0.8, 'backIn');
doTweenX('credi', 'credi', -230, 0.8, 'backIn');
elseif curStep == 40 then
removeLuaSprite('letrero', true)
removeLuaText('name', true)
removeLuaText('credi', true)
end
end