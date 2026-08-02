function onCreate()
        makeLuaText('liri', '', 900, 195, 500)
    setTextSize('liri', 17)
    scaleObject('liri', 0.98, 1.4)
    setObjectCamera('liri', 'other')
    addLuaText('liri', true)
    setTextFont('liri', 'Ticketing.ttf')
    setTextAlignment('liri', 'center')
    setTextBorder('liri',1, '000000')
        end
        function onEvent(name, value1, value2)
            if name == 'Lyrics' then
            setTextString('liri', value1)
            setTextColor('liri', value2)
            runTimer('procesoParaEliminar', 2.5)
            setProperty('liri.visible', true)
            end
                if value2 == "" then
                    setTextColor('liri', 'FFFFFF')
                    end
    end
        function onTimerCompleted(tag, loops, loopsLeft)
            if tag == 'procesoParaEliminar' then
                setProperty('liri.visible', false)
            end
        end