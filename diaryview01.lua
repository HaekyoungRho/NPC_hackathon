-----------------------------------------------------------------------------------------
--
-- view1.lua
--
-----------------------------------------------------------------------------------------

-- json 파싱
local json = require('json')

local Data,pos,msg

local function parse()
	local filename = system.pathForFile("Content/JSON/diaryStory.json")
	Data,pos,msg = json.decodeFile(filename)

	-- 디버그
	if Data then
		print(Data[1].type)
	else
		print(pos)
		print(msg)
	end
	--
end
parse()
--

local composer = require( "composer" )
local scene = composer.newScene()

function scene:create( event )
	local sceneGroup = self.view
	
	local background = display.newImageRect("Content/PNG/diary/일지_배경.png", display.contentWidth, display.contentHeight)
	background.x, background.y = display.contentWidth/2, display.contentHeight/2

	local speakerImg = display.newRect(display.contentCenterX, display.contentHeight*0.7, 900, 900)
	local speaker = display.newRect(display.contentCenterX, display.contentHeight*0.2, 700, 700)
	local index = 1

	local button2 = display.newImageRect("Content/PNG/diary/일지_닫기버튼.png",150*0.4,200*0.4)
	button2.x,button2.y=display.contentWidth*0.95,display.contentHeight*0.05

	local arrowleft=display.newImageRect("Content/PNG/diary/arrow.png",80, 80)
	arrowleft.xScale= arrowleft.xScale*-1
	arrowleft.x, arrowleft.y = speaker.x-320, speaker.y - 100
	arrowleft.alpha=0
	
	local arrowright=display.newImageRect("Content/PNG/diary/arrow.png",80, 80)
	arrowright.x, arrowright.y = speaker.x+320, speaker.y - 100

	
	local function nextScript()
		if(index< #Data) then
			arrowleft.alpha=1
			arrowright.alpha=1
			if(Data[index].type == "background") then
				speakerImg.alpha = 1
				speakerImg.fill = {
					type = "image",
					filename = Data[index].img
				}
				speaker.alpha = 1
				speaker.fill = {
					type = "image",
					filename = Data[index].img2
				}
				if index == #Data then
					arrowright.alpha=0
				elseif index == 1 then
					arrowleft.alpha=0
				end
			end
		end
	end

	local function beforeScript()
		if(index>=1) then	
			arrowleft.alpha=1
			arrowright.alpha=1
			if(Data[index].type == "background") then
				speakerImg.alpha = 1
				speakerImg.fill = {
					type = "image",
					filename = Data[index].img
				}
				speaker.alpha = 1
				speaker.fill = {
					type = "image",
					filename = Data[index].img2
				}
				if index == 1 then
					arrowleft.alpha=0
				end
			end
		end
	end

	nextScript()
	local function tap_next(event)
		index = index + 1
		print(index)
		nextScript()
	end

	local function tap_before(event)
		index=index-1	
		print(index)
		beforeScript()
	end

	arrowleft:addEventListener("tap", tap_before)
	arrowright:addEventListener("tap",tap_next)
	
	local function tap( event )
		composer.removeScene("diaryview01")
		composer.gotoScene("diaryview02")
	end

	background:addEventListener("tap",tap)

	-- 레이어 정리
	sceneGroup:insert(background)
	sceneGroup:insert(speakerImg)
	sceneGroup:insert(speaker)
	sceneGroup:insert(button2)

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

return scene