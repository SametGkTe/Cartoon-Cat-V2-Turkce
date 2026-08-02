function onCreatePost()
if songName == 'ReRuns' then
if lowQuality then
setProperty('camGame.alpha', 0)
end
if not lowQuality then
makeLuaSprite("blackshit", "", 0, 0)
makeGraphic('blackshit', 800, 700, '000000')
addLuaSprite('blackshit', true)
scaleObject('blackshit', 2, 2)
setObjectCamera('blackshit', 'hud')
setObjectOrder('blackshit',0)

makeLuaSprite("vignette", "cc/cc_go", 0, 0)
setObjectCamera('vignette', 'hud')
addLuaSprite('vignette', false)
scaleObject('vignette', 2, 2)
setObjectOrder('vignette',0)
setProperty('vignette.antialiasing',false)

makeAnimatedLuaSprite('ST1','cc/static/static2',0,0)
addAnimationByPrefix('ST1', 'static', 'vine-boom', 24, true);
setObjectCamera('ST1','hud')
setProperty('ST1.alpha',0)
setProperty('ST1.antialiasing',false)
scaleObject('ST1',2.5, 2.5)
addLuaSprite('ST1')

makeAnimatedLuaSprite('ST','cc/static/static1',0,0)
addAnimationByPrefix('ST', 'static', 'vine-boom', 24, true);
setObjectCamera('ST','hud')
setProperty('ST.alpha',0)
setProperty('ST.antialiasing',false)
scaleObject('ST',2.5, 2.5)
addLuaSprite('ST')
end
if version >= '0.7' then
    makeAnimatedLuaSprite('cd','characters/CD_remake_animations',708,-1001)
    addAnimationByPrefix('cd', 'fall', 'cd animation falling', 24, false);
    addAnimationByPrefix('cd','loop','CD Remake idle',24,true)
    objectPlayAnimation('cd','loop',false);
    scaleObject('cd',1.6, 1.6)
    addLuaSprite('cd')
    setProperty('cd.alpha',0.00001)
    end
makeAnimatedLuaSprite('cd_glitch','cb_glitch',0,0)
addAnimationByPrefix('cd_glitch', 'static', 'cb', 24, true);
setObjectCamera('cd_glitch','other')
setProperty('cd_glitch.alpha',0.00001)
scaleObject('cd_glitch',1.7, 1.7)
addLuaSprite('cd_glitch')
if not lowQuality then
makeAnimatedLuaSprite('guards','cc/mallnew/guards_bg',-117,310)
addAnimationByPrefix('guards', 'idle', 'guardias reruns', 24, true);
setScrollFactor('guards', 0.90, 0.90);
setProperty('guards.alpha',0)
scaleObject('guards',1.75, 1.75)
addLuaSprite('guards', false)
end
makeLuaSprite("whiteshit", "", -909, -420)
makeGraphic('whiteshit', 890, 700, 'FFFFFF')
addLuaSprite('whiteshit', false)
scaleObject('whiteshit', 3.6, 3.5)
setProperty('whiteshit.alpha', 0.00001)

setProperty('camGame.zoom', 2.4)
end
end

function onSongStart()
if songName == 'ReRuns' then
doTweenAlpha('blackshitOut', 'blackshit', 0.5, 7.5)
doTweenZoom('camOut', 'camGame', 1.2, 7.5)
if lowQuality then
doTweenAlpha('cammmm', 'camGame', 0.5, 7.5)
end
end
end

function onBeatHit()
if songName == 'ReRuns' then
if curBeat == 33 then
doTweenAlpha('blackshitIn', 'blackshit', 1, 0.4)
if lowQuality then
doTweenAlpha('cammmm', 'camGame', 0, 0.4)
end
end
if curBeat == 34 then
setProperty('vignette.alpha', 0.00001)
setProperty('blackshit.alpha', 0)
setProperty('camGame.alpha', 1)
end
if curBeat == 96 then
doTweenAlpha('vignetteIn', 'vignette', 0.8, 1.5)
end
if curBeat == 98 then
setProperty('guards.alpha', 1)
end
if curBeat == 112 then
doTweenAlpha('STalpha', 'ST', 0.8, 0.8)
doTweenAlpha('ST1alpha', 'ST1', 0.8, 0.8)
doTweenAlpha('blackshitIn', 'blackshit', 1, 0.4)
if lowQuality then
doTweenAlpha('cammmm', 'camGame', 0, 0.4)
end
doTweenAlpha('camHUDFade', 'camHUD', 0.1, 0.8)
doTweenZoom('camIn', 'camGame', 1.8, 0.8)
end
if curBeat == 114 then
setProperty('camGame.zoom', 0.8)
setProperty('ST.alpha', 0.00001)
setProperty('ST1.alpha', 0.00001)
setProperty('camHUD.alpha', 1)
setProperty('blackshit.alpha', 0.00001)
setProperty('camGame.alpha', 1)
doTweenAlpha('blackshitIn', 'blackshit', 0.8, 7.8)
if lowQuality then
doTweenAlpha('cammmm', 'camGame', 0.2, 7.8)
end
doTweenZoom('camIn', 'camGame', 1.2, 7.8)
end
if curBeat == 131 then 
setProperty('blackshit.alpha', 0.00001)
setProperty('camGame.alpha', 1)
setProperty('vignette.alpha', 0.00001)
end
if curBeat == 160 then
doTweenAlpha('blackshitIn', 'blackshit', 1, 0.8)
if lowQuality then
doTweenAlpha('cammmm', 'camGame', 0, 0.8)
end
doTweenAlpha('camHUDFade', 'camHUD', 0.1, 0.8)
doTweenAlpha('vignetteIn', 'vignette', 0.8, 1.5)
doTweenAlpha('cd_glitchIn', 'cd_glitch', 1, 0.8)
playAnim('cd_glitch', 'cb', true)
end
if curBeat == 162 then
setProperty('blackshit.alpha', 0.00001)
setProperty('camGame.alpha', 1)
setProperty('camHUD.alpha', 1)
setProperty('vignette.alpha', 0.00001)
setProperty('vignette.alpha', 0)
setProperty('cd_glitch.alpha', 0)
removeLuaSprite('cd_glitch', true)
for i=0,3 do
noteTweenAlpha('noteFade'..i, i, 0.4, 4, 'linear')
noteTweenX('centerSlide'..i, i, (-228 + (getPropertyFromClass('Note', 'swagWidth') * i) + (screenWidth / 2)), 4, 'linear')
noteTweenX('centerSlide'..i + 4, i + 4, (-228 + (getPropertyFromClass('Note', 'swagWidth') * i) + (screenWidth / 2)), 4, 'linear')
end
end
if curBeat == 176 then
doTweenAlpha('blackshitIn', 'blackshit', 1, 0.8)
if lowQuality then
doTweenAlpha('cammmm', 'camGame', 0, 0.8)
end
end
if curBeat == 179 then
setProperty('blackshit.alpha', 0.00001)
setProperty('camGame.alpha', 1)
setProperty('vignette.alpha', 0.00001)
for i=0,3 do
noteTweenAlpha('noteUnFade'..i, i, 1, 0.4, 'linear')
noteTweenX('noteReturn'..i, i, _G['defaultOpponentStrumX'..i], 0.4, 'bounceOut')
noteTweenX('noteReturn'..i + 4, i + 4, _G['defaultPlayerStrumX'..i], 0.4, 'bounceOut')
end
end
if curBeat == 209 then
setProperty('camGame.alpha', 0.00001)
setProperty('camHUD.alpha', 0.00001)
setProperty('whiteshit.alpha', 1)
setProperty('vignette.alpha', 1)
end
if curBeat == 210 then
setProperty('camGame.alpha', 1)
setProperty('camHUD.alpha', 1)
setProperty('dad.color', '0xFF000000')
setProperty('boyfriend.color', '0xFF000000')
setProperty('gf.color', '0xFF000000')
cameraFlash('game', '0xFFFF0000', 0.5, true)
doTweenZoom('camOut', 'camGame', 0.4, 3)
end
if curBeat == 224 then
doTweenAlpha('blackshitIn', 'blackshit', 1, 0.8)
if lowQuality then
doTweenAlpha('cammmm', 'camGame', 0, 0.8)
end
end
if curBeat == 226 then
setProperty('blackshit.alpha', 0.00001)
setProperty('camGame.alpha', 1)
end
if curBeat == 240 then
doTweenZoom('camIn', 'camGame', 1.8, 0.4)
doTweenAlpha('blackshitIn', 'blackshit', 1, 0.8)
if lowQuality then
doTweenAlpha('cammmm', 'camGame', 0, 0.8)
end
doTweenAlpha('STin', 'ST', 1, 0.4)
doTweenAlpha('ST1in', 'ST1', 1, 0.4)
end
if curBeat == 241 or curBeat == 273 then
doTweenAlpha('STout', 'ST', 0.00001, 0.4)
doTweenAlpha('ST1out', 'ST1', 0.00001, 0.4)
end
if curBeat == 242 then
setProperty('blackshit.alpha', 0)
setProperty('camGame.alpha', 1)
setProperty('whiteshit.alpha', 0)
removeLuaSprite('whiteshit', true)
doTweenColor('dadColorReturn', 'dad', '0xFFFFFFFF', 0.00001)
doTweenColor('boyfriendColorReturn', 'boyfriend', '0xFFFFFFFF', 0.00001)
doTweenColor('gfColorReturn', 'gf', '0xFFFFFFFF', 0.00001)
end
if curBeat == 258 then
doTweenAlpha('blackshitIn', 'blackshit', 0.8, 2.8)
if lowQuality then
doTweenAlpha('cammmm', 'camGame', 0.2, 2.8)
end
end
if curBeat == 264 then
doTweenAlpha('blackshitOut', 'blackshit', 0.00001, 0.8)
if lowQuality then
doTweenAlpha('cammmm', 'camGame', 1, 0.8)
end
end
if curBeat == 266 then
doTweenZoom('camIn', 'camGame', 2.4, 8)
doTweenAlpha('camGameFade', 'camGame', 0.00001, 8)
doTweenAlpha('camHUDFade', 'camHUD', 0.00001, 8)
end
if curBeat == 268 then
doTweenAlpha('STin', 'ST', 0.5, 0.8)
end
if curBeat == 272 or curBeat == 277 then
setProperty('ST.alpha', 1)
setProperty('ST1.alpha', 1)
end
if curBeat == 270 or curBeat == 278 then
setProperty('ST.alpha', 0.00001)
setProperty('ST1.alpha', 0.00001)
end
if curBeat == 211 or curBeat == 212 or curBeat == 213 or curBeat == 214 or curBeat == 215 or curBeat == 216 or curBeat == 218
or curBeat == 220 or curBeat == 222 or curBeat == 223 or curBeat == 224 or curBeat == 225 or curBeat == 226 or curBeat == 227 
or curBeat == 228 or curBeat == 230 or curBeat == 231 or curBeat == 232 or curBeat == 234 or curBeat == 236 or curBeat == 237
or curBeat == 238 or curBeat == 239 then
cameraFlash('game', '0xFFFF0000', 0.5, true)
end
end
end

function onStepHit()
if songName == 'ReRuns' then
    if curBeat == 524 then
removeLuaSprite('UpperBar', true)
removeLuaSprite('LowerBar', true)
        end
if curStep == 980 then
setProperty('ST.alpha', 1)
end
if curStep == 981 then
setProperty('ST.alpha', 0.00001)
if version <= '0.7' then
makeAnimatedLuaSprite('cd','characters/CD_remake_animations',708,-1001)
addAnimationByPrefix('cd', 'fall', 'cd animation falling', 24, false);
addAnimationByPrefix('cd','loop','CD Remake idle',24,true)
objectPlayAnimation('cd','loop',false);
scaleObject('cd',1.6, 1.6)
addLuaSprite('cd')
end
setProperty('cd.alpha',1)
setProperty('cd.x', 708)
setProperty('cd.y', -1001)
objectPlayAnimation('cd', 'fall', true)
end
if curStep == 984 then
setProperty('ST.alpha', 1)
end
if curStep == 986 then
setProperty('ST.alpha', 0.00001)
setProperty('cd.x', 730)
setProperty('cd.y', 320)
objectPlayAnimation('cd', 'loop', true)
end
if curStep == 994 then
doTweenAlpha('ST1in', 'ST1', 1, 0.4)
end
if curStep == 1000 or curStep == 1016 then
setProperty('ST1.alpha', 0.00001)
end
if curStep == 1014 then
setProperty('ST1.alpha', 0.00001)
end
end
end