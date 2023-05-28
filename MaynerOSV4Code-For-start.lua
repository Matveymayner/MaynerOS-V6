local component = require("component")

local computer = require("computer")

local event = require("event")

local term = require("term")

local gpu = component.gpu

-- Функция для вывода сообщения на экран

local function message(str)

  gpu.setForeground(0xFFFFFF)

  gpu.setBackground(0x000000)

  term.clear()

  term.setCursor(1,1)

  print(str)

end

-- Функция для получения случайного числа

local function random()

  return math.random(1, 100)

end

-- Функция для удаления операционной системы

local function deleteOS()

  message("Are you sure you want to delete the OS? (y/n)")

  local _, _, _, _, _, response = event.pull("key_down")

  if response == 21 then

    rm "os.lua"

    os.exit()

  else

    message("OS delete aborted.")

  end

end

-- Функция для вывода строки команд

local function printCommands()

  message("1. shutdown  2. reboot  3. random number  4. delete OS  5. BSOD  6. eternal shutdown")

end

-- Функция для вечного выключения

local function eternalShutdown()

while true do

    computer.shutdown()

  end

end

-- Функция для обработки команд

local function handleCommand(command)

  if command == "1" then

    computer.shutdown()

  elseif command == "2" then

    computer.shutdown(true)

  elseif command == "3" then

    message("Random number: " .. random())

  elseif command == "4" then

    deleteOS()

  elseif command == "5" then

       gpu.setForeground(0xFFFFFF)
    gpu.setBackground(0x0000FF)
    gpu.fill(1, 1, 80, 25, " ")
    gpu.set(32, 12, "your pc dead sorry :(")
    gpu.setBackground(0x000000)
    while true do
      os.sleep(1)
    end

  elseif command == "6" then

    eternalShutdown()

  else

    message("Invalid command.")

  end

end

-- Функция для установки операционной системы

local function installOS()

  message("Installing OS...")

  os.sleep(1)

  local handle = io.open("/os.lua", "w")

  handle:write("-- Insert OS code here.")

  handle:close()

  message("OS installed successfully.")

end

-- Функция для прошивки БИОСа

local function flashBIOS()

  message("Flashing BIOS...")

  os.sleep(1)

  message("BIOS flashed successfully.")

end

-- Главный цикл программы

while true do

  printCommands()

  io.write("> ")

  local command = io.read()

  handleCommand(command)

end
