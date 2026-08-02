function onCreate()
    setPropertyFromClass('substates.GameOverSubstate', 'songGameOverMode', 'taf')
end

function onDestroy()
    setPropertyFromClass('substates.GameOverSubstate', 'songGameOverMode', 'meatbf')
end