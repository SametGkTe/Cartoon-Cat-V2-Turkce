local videoStarted = false

function onEndSong()
    if isStoryMode and not seenCutscene and not videoStarted then
        videoStarted = true
        startVideo('taf-post-cutscene')
        return Function_Stop
    end
    return Function_Continue
end

function onVideoFinished(name)
    if name == 'taf-post-cutscene' then
        exitSong()
    end
end