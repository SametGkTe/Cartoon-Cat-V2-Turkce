local songTimeLength = 0
local songNameMickey = ''

function onCreate()
    if version >= '0.7' then
        setPropertyFromClass('backend.ClientPrefs','data.timeBarType','Time Left')
    else
        setPropertyFromClass('ClientPrefs','timeBarType','Time Left')
    end
end
function onCreatePost()
    setTimeBarColors('C9C9C9', '000000')
    if not hideHud then
        songNameMickey = songName
        if string.find(songNameMickey,'-',0,true) ~= nil then
            songNameMickey = string.gsub(songNameMickey,'-',' ')
        end
            songTimeLength = 121200
            makeLuaSprite('unknownTime',nil,121200,0)
        end

        setProperty('scoreTxt.visible',false)
        setProperty('timeBar.antialiasing',false)
        setProperty('timeBar.scale.x',3.25)
        setProperty('timeBar.scale.y',1.4)
        setProperty('timeTxt.visible',false)


        local textMickeySize = 17
        if not downscroll then
            setProperty('timeBar.y',screenHeight + 10 - (getProperty('timeBar.height') * getProperty('timeBar.scale.y')))
            makeLuaText('songTimeMickey','0:00 - 0:00',115,screenWidth/2 - 80,getProperty('timeBar.y') - 40)
            makeLuaText('scoreTextMickey','Score: 0',200,25,screenHeight - 150)
            makeLuaText('missesTextMickey','Misses: 0',200,25,screenHeight - 120)
            makeLuaText('acurracyTextMickey','Acurracy: 0',200,25,screenHeight - 90)
            makeLuaText('songNameTextMickey',songNameMickey,300,15,getProperty('timeBar.y') - 35)
            makeLuaText('sickTextMickey','Sick: 0',200,screenWidth - 100,screenHeight - 150)
            makeLuaText('goodTextMickey','Good: 0',200,screenWidth - 100,screenHeight - 120)
            makeLuaText('badTextMickey','Bad: 0',200,screenWidth - 100,screenHeight - 90)
            makeLuaText('shitTextMickey','Shit: 0',200,screenWidth - 100,screenHeight - 60)
            
        else
            setProperty('timeBar.y',0)
            makeLuaText('songTimeMickey','0:00 - 0:00',160,screenWidth/2 - 80,getProperty('timeBar.y') + 40)
            makeLuaText('scoreTextMickey','Skor: 0',200,25,90)
            makeLuaText('missesTextMickey','Iskalar: 0',200,25,120)
            makeLuaText('acurracyTextMickey','Doğruluk: 0',200,25,150)
            makeLuaText('songNameTextMickey',songNameMickey,300,15,getProperty('timeBar.y') + 35)
            makeLuaText('sickTextMickey','müq: 0',200,screenWidth - 100,60)
            makeLuaText('goodTextMickey','iyi: 0',200,screenWidth - 100,90)
            makeLuaText('badTextMickey','kötü: 0',200,screenWidth - 100,120)
            makeLuaText('shitTextMickey','berbat: 0',200,screenWidth - 100,150)
        end
        setTextAlignment('songTimeMickey','center')
        setObjectCamera('songTimeMickey','hud')
        setTextFont('songTimeMickey','MilkyNice.ttf')
        setTextSize('songTimeMickey',textMickeySize)
        addLuaText('songTimeMickey')
        scaleObject('songTimeMickey', 1.3, 1.3)


        setTextAlignment('scoreTextMickey','left')
        setObjectCamera('scoreTextMickey','hud')
        setTextFont('scoreTextMickey','MilkyNice.ttf')
        setTextSize('scoreTextMickey',textMickeySize)
        addLuaText('scoreTextMickey')
        scaleObject('scoreTextMickey', 1.3, 1.3)


        setTextAlignment('missesTextMickey','left')
        setObjectCamera('missesTextMickey','hud')
        setTextFont('missesTextMickey','MilkyNice.ttf')
        setProperty('missesTextMickey.antialiasing',false)
        setTextSize('missesTextMickey',textMickeySize)
        addLuaText('missesTextMickey')
        scaleObject('missesTextMickey', 1.3, 1.3)


        setTextAlignment('acurracyTextMickey','left')
        setObjectCamera('acurracyTextMickey','hud')
        setTextSize('acurracyTextMickey',textMickeySize)
        setTextFont('acurracyTextMickey','MilkyNice.ttf')
        setProperty('acurracyTextMickey.antialiasing',false)
        addLuaText('acurracyTextMickey')
        scaleObject('acurracyTextMickey', 1.3, 1.3)


        setTextAlignment('songNameTextMickey','left')
        setObjectCamera('songNameTextMickey','hud')
        setTextFont('songNameTextMickey','MilkyNice.ttf')
        setTextSize('songNameTextMickey',25)
        addLuaText('songNameTextMickey')


        setTextAlignment('sickTextMickey','left')
        setObjectCamera('sickTextMickey','hud')
        setTextFont('sickTextMickey','MilkyNice.ttf')
        setTextSize('sickTextMickey',textMickeySize)
        addLuaText('sickTextMickey')
        scaleObject('sickTextMickey', 1.3, 1.3)


        setTextAlignment('goodTextMickey','left')
        setObjectCamera('goodTextMickey','hud')
        setTextFont('goodTextMickey','MilkyNice.ttf')
        setTextSize('goodTextMickey',textMickeySize)
        addLuaText('goodTextMickey')
        scaleObject('goodTextMickey', 1.3, 1.3)


        setTextAlignment('badTextMickey','left')
        setObjectCamera('badTextMickey','hud')
        setTextFont('badTextMickey','MilkyNice.ttf')
        setTextSize('badTextMickey',textMickeySize)
        addLuaText('badTextMickey')
        scaleObject('badTextMickey', 1.3, 1.3)


        setTextAlignment('shitTextMickey','left')
        setObjectCamera('shitTextMickey','hud')
        setTextFont('shitTextMickey','MilkyNice.ttf')
        setTextSize('shitTextMickey',textMickeySize)
        addLuaText('shitTextMickey')
        scaleObject('shitTextMickey', 1.3, 1.3)
    end

function onUpdateScore()
    setTextString('scoreTextMickey','Skor: '..getProperty('songScore'))
    setTextString('missesTextMickey','Iskalar: '..getProperty('songMisses'))
    setTextString('acurracyTextMickey','Doğruluk: '..math.floor(getProperty('ratingPercent') * 10000)/100)

    if version >= '0.7' then
        setTextString('sickTextMickey','müq: '..getProperty('ratingsData[0].hits'))
        setTextString('goodTextMickey','iyi: '..getProperty('ratingsData[1].hits'))
        setTextString('badTextMickey','kötü: '..getProperty('ratingsData[2].hits'))
        setTextString('shitTextMickey','berbat: '..getProperty('ratingsData[3].hits'))
    else
        setTextString('sickTextMickey','müq: '..getProperty('sicks'))
        setTextString('goodTextMickey','iyi: '..getProperty('goods'))
        setTextString('badTextMickey','kötü: '..getProperty('bads'))
        setTextString('shitTextMickey','berbat: '..getProperty('shits'))
    end

end

function onSongStart()
    if luaSpriteExists('unknownTime') then
        setProperty('songLength',getProperty('unknownTime.x'))
    end
end
function onUpdate()
    if not hideHud then
        songTimeLength = getProperty('songLength')
        local songPos = math.max(0,getSongPosition())
        if songPos >= songTimeLength then
            songTimeLength = songPos
        end
        setTextString('songTimeMickey',math.floor(songPos/60000)..':'..math.floor((songPos/10000) % 6)..math.floor((songPos/1000) % 10)..' - 3:31')

    end
end

function onDestroy()
    if version >= '0.7' then
        setPropertyFromClass('backend.ClientPrefs','data.timeBarType',timeBarType)
    else
        setPropertyFromClass('ClientPrefs','timeBarType',timeBarType)
    end
end