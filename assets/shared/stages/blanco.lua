function onCreate()
    makeLuaSprite('negro', '', 0, 0);
    makeGraphic('negro',680,340,'ffffff')
    addLuaSprite('negro', false);
    setLuaSpriteScrollFactor('negro',0,0)
    setProperty('negro.scale.x',3.7)
    setProperty('negro.scale.y',3.8)
if not hideHud then
    makeLuaSprite('iconT','icons/t-icon', 0, 0)
addLuaSprite('iconT', true)
setObjectCamera('iconT', 'hud')
end
function onUpdatePost(elapsed)
    setProperty('iconT.x', getProperty('iconP2.x')-45)
    setProperty('iconT.y', getProperty('iconP2.y')-31)

    setProperty('iconT.scale.x', getProperty('iconP2.scale.x')-0.2)
    setProperty('iconT.scale.y', getProperty('iconP2.scale.y')-0.2)
	end
end -- when codeas un extra icon de volada cuando el port estaba a punto de salir :skull:
function onCreatePost()
    setObjectOrder('iconP2', 10)
        setObjectOrder('iconP1', 7)
        setObjectOrder('iconT', 5)
        setObjectOrder('healthBar', 3)
        setObjectOrder('healthBarBG', 1)
	removeLuaSprite('vignetteog', true)
	removeLuaSprite('static', true)
    doTweenColor('e', 'noteCombo', '000000', 0.01, 'linear')
end