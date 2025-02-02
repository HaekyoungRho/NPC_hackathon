--병아리 게임 시작

local composer = require( "composer" )
local scene = composer.newScene()
function scene:create( event )
	local sceneGroup = self.view


	local function catch( event )
		--if(event.phase == "began") then
			composer.removeScene("view05_chick_game_start")
			composer.gotoScene("view06_chick_game")
		--end
	end


    local background = display.newImage( "Content/PNG/타이틀/미니게임타이틀_병아리.png", display.contentWidth, display.contentHeight)
    background.x = display.contentWidth/2
    background.y = display.contentHeight/2
    sceneGroup:insert(background)
  


    background:addEventListener("touch", catch)

end

function scene:show( event )
	local sceneGroup = self.view
	local phase = event.phase

	if phase == "will" then
		-- Called when the scene is still off screen and is about to move on screen
	elseif phase == "did" then
		-- Called when the scene is now on screen
		-- 
		-- INSERT code here to make the scene come alive
		-- e.g. start timers, begin animation, play audio, etc.
	end	
end

function scene:hide( event )
	local sceneGroup = self.view
	local phase = event.phase

	if event.phase == "will" then
		-- Called when the scene is on screen and is about to move off screen
		--
		-- INSERT code here to pause the scene
		-- e.g. stop timers, stop animation, unload sounds, etc.)
    elseif phase == "did" then
        composer.removeScene("view05_chick_game_start")
		-- Called when the scene is now off screen
	end
end

function scene:destroy( event )
	local sceneGroup = self.view
	
	-- Called prior to the removal of scene's "view" (sceneGroup)
	-- 
	-- INSERT code here to cleanup the scene
	-- e.g. remove display objects, remove touch listeners, save state, etc.
end

---------------------------------------------------------------------------------

-- Listener setup
scene:addEventListener( "create", scene )
scene:addEventListener( "show", scene )
scene:addEventListener( "hide", scene )
scene:addEventListener( "destroy", scene )

-----------------------------------------------------------------------------------------

--local bgMusic = audio.loadStream("bgm.mp3")
--audio.setVolume( 0.75 )

--audio.play(bgMusic, {loops = -1, fadein = 5000})
-- loop : -1 --> 무한
return scene
