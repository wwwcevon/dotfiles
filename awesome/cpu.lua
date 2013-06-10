local io = io
local string = string

module("cpu")

jiffies = {}
function activecpu(color1, color2)
  local s = ""
  for line in io.lines("/proc/stat") do
    local cpu, newjiffies = string.match(line, "(cpu)\ +(%d+)")
    if cpu and newjiffies then
      if not jiffies[cpu] then
        jiffies[cpu] = newjiffies
      end
      --The string.format prevents your task list from jumping around
      --when CPU usage goes above/below 10%
      s = s .. " <span color='" .. color1 .. "'>" .. cpu .. ":</span> " .. string.format("%02d", (newjiffies-jiffies[cpu]) / 2) .. "% "
      jiffies[cpu] = newjiffies
    end
  end
  return "<span color='" .. color2 .. "' >"..s.."</span>"
end
