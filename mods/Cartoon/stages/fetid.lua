local work = false

function onCreate()
makeLuaSprite("bart-esqueleto", "cc/fetid king/bg1", -175, 76)
addLuaSprite('bart-esqueleto', false)
scaleObject('bart-esqueleto', 1.72, 1.72)

makeLuaSprite("nigger", "cc/fetid king/dark", -20, 0)
        setObjectCamera('nigger', 'hud')
        addLuaSprite('nigger', false)
        scaleObject('nigger', 1.77, 1.5)
        setObjectOrder('nigger',0)
        setProperty('nigger.antialiasing',false)
end

function onCreatePost()
	removeLuaSprite('vignetteog', true)
	noteTweenX('Movement oX 0', 0, defaultPlayerStrumX0 - 14000, 0.00000000001)
	noteTweenX('Movement oX 1', 1, defaultPlayerStrumX1 - 14000, 0.00000000001)
	noteTweenX('Movement oX 2', 2, defaultPlayerStrumX2 - 14000, 0.00000000001)
	noteTweenX('Movement oX 3', 3, defaultPlayerStrumX3 - 14000, 0.00000000001)

	noteTweenX('Movement X 0', 4, 315, 0.00000000001)
	noteTweenX('Movement X 1', 5, 427, 0.00000000001)
	noteTweenX('Movement X 2', 6, 733, 0.00000000001)
	noteTweenX('Movement X 3', 7, 845, 0.00000000001)
end

function onUpdate(elapsed)
	if work == true then
			for i=0,4,1 do
			setPropertyFromGroup('opponentStrums', i, 'visible', false)
		end
		for i = 0, getProperty('unspawnNotes.length')-1 do
			if not getPropertyFromGroup('unspawnNotes', i, 'mustPress') then	
				setPropertyFromGroup('unspawnNotes', i, 'visible', false); --Change texture
				end
			end
				songPos = getSongPosition()
				local currentBeat = (songPos/1000)
	noteTweenY('player1', 4, defaultPlayerStrumY3 - 600*math.sin((currentBeat+8*0.1)*math.pi), 3)
	noteTweenY('player2', 5, defaultPlayerStrumY1 + 300*math.sin((currentBeat+8*0.1)*math.pi), 3)
	noteTweenY('player3', 6, defaultPlayerStrumY0 - 600*math.sin((currentBeat+8*0.1)*math.pi), 3)
	noteTweenY('player4', 7, defaultPlayerStrumY2 + 300*math.sin((currentBeat+8*0.1)*math.pi), 3)
	end
end

function onStepHit()
	if curStep == 1088 then
		work=true
	end
end