local playedIntro = false

function onStartCountdown()
    if isStoryMode and not seenCutscene and not playedIntro then
        playedIntro = true
        startVideo('ff intro cutscene')
        return Function_Stop
    end
    return Function_Continue
end