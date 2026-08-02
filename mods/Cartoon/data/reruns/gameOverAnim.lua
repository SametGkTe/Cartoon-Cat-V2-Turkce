function onCreate()
    setPropertyFromClass('substates.GameOverSubstate', 'songGameOverMode', 'spooky')
end

function onDestroy()
    setPropertyFromClass('substates.GameOverSubstate', 'songGameOverMode', 'meatbf')
end