function onCreate()
makeLuaSprite('calle','cc/highway/bg1', 0, 0)
addLuaSprite('calle', false)
scaleObject('calle', 2.5, 2.5)

makeAnimatedLuaSprite('auto','cc/highway/auto', 240, 150)
addAnimationByPrefix('auto', 'idle', 'auto fondo', 8, true);
scaleObject('auto',2.5, 2.5)
addLuaSprite('auto', false)
if not hideHud then
makeLuaSprite('iconGF','icons/ickkck', 0, 0)
addLuaSprite('iconGF', true)
setObjectCamera('iconGF', 'hud')
setProperty('iconGF.flipX', true)
end
function onUpdatePost(elapsed)
    setObjectOrder('iconGF', getObjectOrder('iconP1')+10)
    setProperty('iconGF.x', getProperty('iconP1.x')+104)
    setProperty('iconGF.y', getProperty('iconP1.y')-13)

    setProperty('iconGF.scale.x', getProperty('iconP1.scale.x')-0.2)
    setProperty('iconGF.scale.y', getProperty('iconP1.scale.y')-0.2)
	end -- when codeas un extra icon de volada cuando el port estaba a punto de salir :skull:
end