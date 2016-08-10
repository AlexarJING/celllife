function love.load(arg) --This function is called exactly once at the beginning of the game.
	--font = love.graphics.newFont("res/font/simsun.ttc", 20)
    cell=require("scr.game.cell")
end

function love.draw() --Callback function used to draw on the screen every frame.
	--love.graphics.setFont(font)
	cell:draw()

end

function love.update(dt) --Callback function used to update the state of the game every frame.
    if love.mouse.isDown("l") then cell:newSeed(love.mouse.getPosition()) end 
    cell:update(dt)
end 

function love.mousepressed(x,y,button)
    
end

--[[
function love.quit() --Callback function triggered when the game is closed.
end 
function love.resize(w,h) --Called when the window is resized.
end 
function love.textinput(text) --Called when text has been entered by the user.
end 
function love.threaderror(thread, err ) --Callback function triggered when a Thread encounters an error.
end 
function love.visible() --Callback function triggered when window is shown or hidden.
end 
function love.mousefocus(f)--Callback function triggered when window receives or loses mouse focus.
end
function love.mousepressed(x,y,button) --Callback function triggered when a mouse button is pressed.
end 
function love.mousereleased(x,y,button)--Callback function triggered when a mouse button is released.
end 
function love.errhand(err) --The error handler, used to display error messages.
end 
function love.focus(f) --Callback function triggered when window receives or loses focus.
end 
function love.keypressed(key,isrepeat) --Callback function triggered when a key is pressed.
end
function love.keyreleased(key) --Callback function triggered when a key is released.
end 
function love.run() --The main function, containing the main loop. A sensible default is used when left out.

    if love.math then
        love.math.setRandomSeed(os.time())
        for i=1,3 do love.math.random() end
    end

    if love.event then
        love.event.pump()
    end

    if love.load then love.load(arg) end

    -- We don't want the first frame's dt to include time taken by love.load.
    if love.timer then love.timer.step() end

    local dt = 0

    -- Main loop time.
    while true do
        -- Process events.
        if love.event then
            love.event.pump()
            for e,a,b,c,d in love.event.poll() do
                if e == "quit" then
                    if not love.quit or not love.quit() then
                        if love.audio then
                            love.audio.stop()
                        end
                        return
                    end
                end
                love.handlers[e](a,b,c,d)
            end
        end

        -- Update dt, as we'll be passing it to update
        if love.timer then
            love.timer.step()
            dt = love.timer.getDelta()
        end

        -- Call update and draw
        if love.update then love.update(dt) end -- will pass 0 if love.timer is disabled

        if love.window and love.graphics and love.window.isCreated() then
            love.graphics.clear()
            love.graphics.origin()
            if love.draw then love.draw() end
            love.graphics.present()
        end

        if love.timer then love.timer.sleep(0.001) end
    end
end
]]