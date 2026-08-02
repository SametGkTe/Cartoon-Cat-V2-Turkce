function onUpdatePost(elapsed)
	if not downscroll then
		setProperty('iconP1.x', 855)
		setProperty('iconP1.y', 575)
		setProperty('iconP2.x', 245)
		setProperty('iconP2.y', 568)
	end
	if downscroll then
		setProperty('iconP1.x', 855)
		setProperty('iconP1.y', 9)
		setProperty('iconP2.x', 245)
		setProperty('iconP2.y', 1)
	end
end