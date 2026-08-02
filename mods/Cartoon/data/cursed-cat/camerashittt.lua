enabled = true

multiplier = 0.75

function onUpdate()

	if enabled and not (getProperty('paused')) then
	
		local cam = nil

		if stringStartsWith(version, '0.7') then
cam = 'camGame.scroll'
		else
cam = 'camFollowPos'
		end
	
		local camFollowX = getProperty(cam..'.x')
		local camFollowY = getProperty(cam..'.y')
		
		if mustHitSection then
		
--move camera on direction of note
if not (string.find(getProperty('boyfriend.animation.curAnim.name'), 'singLEFT') == nil) then
	setProperty(cam..'.x', camFollowX - multiplier)

elseif not (string.find(getProperty('boyfriend.animation.curAnim.name'), 'singDOWN') == nil) then
	setProperty(cam..'.y', camFollowY + multiplier)

elseif not (string.find(getProperty('boyfriend.animation.curAnim.name'), 'singUP') == nil) then
	setProperty(cam..'.y', camFollowY - multiplier)

elseif not (string.find(getProperty('boyfriend.animation.curAnim.name'), 'singRIGHT') == nil) then
	setProperty(cam..'.x', camFollowX + multiplier)
end

		else
		
--move camera on direction of note
if not (string.find(getProperty('dad.animation.curAnim.name'), 'singLEFT') == nil) then
	setProperty(cam..'.x', camFollowX - multiplier)

elseif not (string.find(getProperty('dad.animation.curAnim.name'), 'singDOWN') == nil) then
	setProperty(cam..'.y', camFollowY + multiplier)

elseif not (string.find(getProperty('dad.animation.curAnim.name'), 'singUP') == nil) then
	setProperty(cam..'.y', camFollowY - multiplier)

elseif not (string.find(getProperty('dad.animation.curAnim.name'), 'singRIGHT') == nil) then
	setProperty(cam..'.x', camFollowX + multiplier)
end
		
		end

--move camera on direction of note
if not (string.find(getProperty('gf.animation.curAnim.name'), 'singLEFT') == nil) then
	setProperty(cam..'.x', camFollowX - multiplier)
	
elseif not (string.find(getProperty('gf.animation.curAnim.name'), 'singDOWN') == nil) then
	setProperty(cam..'.y', camFollowY + multiplier)
	
elseif not (string.find(getProperty('gf.animation.curAnim.name'), 'singUP') == nil) then
	setProperty(cam..'.y', camFollowY - multiplier)
	
elseif not (string.find(getProperty('gf.animation.curAnim.name'), 'singRIGHT') == nil) then
	setProperty(cam..'.x', camFollowX + multiplier)
end

local stepCrochet = 0
	
if stringStartsWith(version, '0.7') then
	stepCrochet = getPropertyFromClass('backend.Conductor', 'stepCrochet')
else
	stepCrochet = getPropertyFromClass('Conductor', 'stepCrochet')
end
	
--move back to opponent/boyfriend
if getProperty('gf.holdTimer') >= stepCrochet * 0.0011 * gfCameraTimer then

	if mustHitSection then
	
		setProperty('camFollow.x', getMidpointX('boyfriend') - 100)
		setProperty('camFollow.y', getMidpointY('boyfriend') - 100)
	
		setProperty('camFollow.x', getProperty('camFollow.x') - getProperty('boyfriend.cameraPosition')[1] - getProperty('boyfriendCameraOffset')[1])
		setProperty('camFollow.y', getProperty('camFollow.y') + getProperty('boyfriend.cameraPosition')[2] + getProperty('boyfriendCameraOffset')[2])
		
	else
	
		setProperty('camFollow.x', getMidpointX('dad') + 150)
		setProperty('camFollow.y', getMidpointY('dad') - 100)
	
		setProperty('camFollow.x', getProperty('camFollow.x') + getProperty('dad.cameraPosition')[1] + getProperty('opponentCameraOffset')[1])
		setProperty('camFollow.y', getProperty('camFollow.y') + getProperty('dad.cameraPosition')[2] + getProperty('opponentCameraOffset')[2])
		
	end
	
end
		
		end
		
	end