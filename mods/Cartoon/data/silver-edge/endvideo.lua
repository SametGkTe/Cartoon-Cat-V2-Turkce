local videoStarted = false

function onEndSong()
    if isStoryMode and not videoStarted then
        videoStarted = true
        startVideo('ending')
        return Function_Stop
    end
    
    return Function_Continue
end

function onVideoFinished(name)
    if name == 'ending' then
        endSong() 
    end
end