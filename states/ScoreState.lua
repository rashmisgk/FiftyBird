--[[
    ScoreState Class
    Author: Colton Ogden
    cogden@cs50.harvard.edu

    A simple state used to display the player's score before they
    transition back into the play state. Transitioned to from the
    PlayState when they collide with a Pipe.
]]

ScoreState = Class{__includes = BaseState}

--[[
    When we enter the score state, we expect to receive the score
    from the play state so we know what to render to the State.
]]

function ScoreState:init()
    -- Load medal images
    self.bronzeMedal = love.graphics.newImage('BronzeMedal.png')
    self.silverMedal = love.graphics.newImage('SilverMedal.png')
    self.goldMedal = love.graphics.newImage('GoldMedal.png')

  
end

function ScoreState:enter(params)
    self.score = params.score

  -- Define the minimum score required to earn each medal
  self.bronzeScore = 5
  self.silverScore = 10
  self.goldScore = 15

  -- Determine which medal to award based on the player's score
  self.medal = nil
  
  if self.score >= self.goldScore then
      self.medal = self.goldMedal
  elseif self.score >= self.silverScore then
      self.medal = self.silverMedal
  elseif self.score >= self.bronzeScore then
      self.medal = self.bronzeMedal
  end

end


function ScoreState:update(dt)
    -- go back to play if enter is pressed
    if love.keyboard.wasPressed('enter') or love.keyboard.wasPressed('return') then
        gStateMachine:change('countdown')
    end
end

function ScoreState:render()
    -- simply render the score to the middle of the screen
    love.graphics.setFont(flappyFont)
    love.graphics.printf('Oof! You lost!', 0, 64, VIRTUAL_WIDTH, 'center')


    -- Display the medal and score in the ScoreState
    local MEDAL_SCALE = 0.1

    if self.medal ~= nil then
        love.graphics.draw(self.medal, 
        VIRTUAL_WIDTH/2 - self.medal:getWidth() * MEDAL_SCALE/2 + 3, 
        VIRTUAL_HEIGHT/2 - self.medal:getHeight() * MEDAL_SCALE/2 -5,
        0, 
        MEDAL_SCALE, 
        MEDAL_SCALE)

    end

    love.graphics.setFont(mediumFont)
    love.graphics.printf('Score: ' .. tostring(self.score), 0, 100, VIRTUAL_WIDTH, 'center')


    love.graphics.printf('Press Enter to Play Again!', 0, 160, VIRTUAL_WIDTH, 'center')
end