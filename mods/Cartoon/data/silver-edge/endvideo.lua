local allowEnd = false
local videoPlayed = false

function onEndSong()
    if not allowEnd and isStoryMode then
        if not videoPlayed then
            videoPlayed = true

            setProperty('canPause', false)
            setProperty('camHUD.visible', false)

            startVideo('ending')

            -- Video 4 dakika 50 saniye
            runTimer('videoBitir', 291)
        end
        return Function_Stop
    end

    return Function_Continue
end

function onTimerCompleted(tag, loops, loopsLeft)
    if tag == 'videoBitir' then
        setProperty('canPause', true)
        allowEnd = true
        endSong()
    end
end