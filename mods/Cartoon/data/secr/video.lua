local videoName = 'ghostpig'
local started = false

function onStepHit()
    -- 232. adımda videoyu başlat ve 4 saniye sonra çıkış yapması için zamanlayıcı kur
    if curStep == 232 and not started then
        started = true
        startVideo(videoName)
        
        -- 4 saniye sonra 'siradan_cik' isimli timer çalışacak
        runTimer('siradan_cik', 4.0)
    end
end

function onTimerCompleted(tag, loops, loopsLeft)
    -- Timer bittiğinde çalışacak komut
    if tag == 'siradan_cik' then
        exitSong()
    end
end