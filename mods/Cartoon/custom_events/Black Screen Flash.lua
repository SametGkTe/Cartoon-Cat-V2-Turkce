function onCreate()
    if not lowQuality then
        makeLuaSprite('bflash', '', 0, 0);
        makeGraphic('bflash',680,340,'000000')
        addLuaSprite('bflash', false);
        setObjectCamera('bflash','hud')
        setLuaSpriteScrollFactor('bflash',0,0)
        setProperty('bflash.scale.x',3)
        setProperty('bflash.scale.y',3.4)
        setObjectOrder('bflash', 0);
        setProperty('bflash.alpha',0)
        setProperty('bflash.antialiasing',false)
        end
    end
function onEvent(n,v1,v2)
if n == 'Black Screen Flash' then
    setProperty('bflash.alpha',1)
    doTweenAlpha('flTtw','bflash',0,v1,'linear')
if lowQuality then
setProperty('camGame.alpha',0)
doTweenAlpha('cammm','camGame',1,v1,'linear')
end
end
end