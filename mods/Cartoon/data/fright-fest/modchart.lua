local epicCoolCameraShit = true;

function onStepHit()
    if curStep == 784 then
        setProperty('cameraSpeed', '3')
    end
    if curStep == 848 then
        setProperty('cameraSpeed', '100')
        triggerEvent('Camera Follow Pos', '480', '550')
    end
    if curStep == 857 then
        setProperty('cameraSpeed', '100')
        triggerEvent('Camera Follow Pos', '830', '590')
    end
    if curStep == 865 then
        setProperty('cameraSpeed', '100')
        triggerEvent('Camera Follow Pos', '480', '550')
    end
    if curStep == 872 then
        setProperty('cameraSpeed', '100')
        triggerEvent('Camera Follow Pos', '830', '590')
    end
    if curStep == 880 then
        setProperty('cameraSpeed', '100')
        triggerEvent('Camera Follow Pos', '480', '550')
    end
    if curStep == 888 then
        setProperty('cameraSpeed', '100')
        triggerEvent('Camera Follow Pos', '830', '590')
    end
    if curStep == 896 then
        setProperty('cameraSpeed', '100')
        triggerEvent('Camera Follow Pos', '615', '550')
    end
    if curStep == 940 then
        triggerEvent('Camera Follow Pos', '', '')
    end
    if curStep == 1200 then
        setProperty('cameraSpeed', '100')
        triggerEvent('Camera Follow Pos', '615', '530')
    end
    if curStep == 849 or curStep == 858 or curStep == 866 or curStep == 873 or curStep == 881 or curStep == 889 or curStep == 897 or curStep == 944 then
        setProperty('cameraSpeed', '1')
    end
end