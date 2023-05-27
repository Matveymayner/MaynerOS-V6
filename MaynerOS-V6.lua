local component = require("component")
local event = require("event")
local gpu = component.gpu
local computer = require("computer")
local os = require("os")

-- Функция для вывода сообщения на экран
local function message(str)
  gpu.setForeground(0xFFFFFF)
  gpu.setBackground(0x000000)
  gpu.fill(1, 1, 80, 25, " ")
  gpu.set(1, 1, str)
end

-- Функция для вывода кнопки
local function drawButton(x, y, width, height, text, foreground, background)
  gpu.setForeground(foreground)
  gpu.setBackground(background)
  gpu.fill(x, y, width, height, " ")
  local textX = x + math.floor((width - #text) / 2)
  local textY = y + math.floor(height / 2)
  gpu.set(textX, textY, text)
end

-- Функция для обработки команд
local function handleCommand(command)
  if command == "1" then
    message("Shutting down...")
    os.sleep(2)
    computer.shutdown()
  elseif command == "2" then
    message("Rebooting...")
    os.sleep(2)
    computer.shutdown(true)
  elseif command == "3" then
    message("Random number: " .. tostring(math.random(1, 100)))
  elseif command == "4" then
    message("Are you sure you want to delete the OS? (y/n)")
    local _, _, _, _, _, response = event.pull("key_down")
    if response == 21 then
      os.remove("/MaynerOS-V6.lua")
      os.exit()
    else
      message("OS delete aborted.")
      os.sleep(2)
    end
  elseif command == "5" then
    message("Blue Screen of Death!")
    os.sleep(1)
    computer.shutdown(true)
  elseif command == "6" then
    message("Are you sure you want to shutdown the computer? (y/n)")
    while true do
      local _, _, _, _, _, response = event.pull("key_down")
      if response == 21 then
        message("Shutting down...")
        os.sleep(2)
        computer.shutdown()
      elseif response == 49 then
        message("Shutdown aborted.")
        os.sleep(2)
        break
      end
    end
  elseif command == "shell" then
    os.execute("/MaynerOS-V6.lua")
    os.exit()
  end
end

-- Очищаем экран и устанавливаем фоновый цвет
gpu.setForeground(0xFFFFFF)
gpu.setBackground(0x0000FF)
gpu.fill(1, 1, 80, 25, " ")

-- Выводим логотип
gpu.setForeground(0xFFFFFF)
gpu.setBackground(0x0000FF)
gpu.set(1, 24, "Mayner OS")

-- Выводим кнопки
drawButton(10, 8, 20, 3, "Shutdown", 0xFFFFFF, 0x555555)
drawButton(35, 8, 20, 3, "Reboot", 0xFFFFFF, 0x555555)
drawButton(60, 8, 20, 3, "Shell", 0xFFFFFF, 0x555555)
drawButton(10, 12, 20, 3, "Random", 0xFFFFFF, 0x555555)
drawButton(35, 12, 20, 3, "Delete OS", 0xFFFFFF, 0x555555)
drawButton(60, 12, 20, 3, "Blue Screen", 0xFFFFFF, 0x555555)

-- Ожидаем нажатия кнопки
while true do
  local _, _, x, y = event.pull("touch")
  if x >= 10 and x <= 29 then
    if y == 8 then
      handleCommand("1")
    elseif y == 12 then
      handleCommand("4")
    end
  elseif x >= 35 and x <= 54 then
    if y == 8 then
      handleCommand("2")
    elseif y == 12 then
      handleCommand("5")
    end
  elseif x >= 60 and x <= 79 then
    if y == 8 then
      handleCommand("shell")
    elseif y == 12 then
      handleCommand("3")
    end
  end
end
