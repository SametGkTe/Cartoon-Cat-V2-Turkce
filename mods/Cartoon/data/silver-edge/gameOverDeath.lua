function onCreate()
    setPropertyFromClass('substates.GameOverSubstate', 'songGameOverMode', 'siren')
end

function onDestroy()
    setPropertyFromClass('substates.GameOverSubstate', 'songGameOverMode', 'meatbf')
end