local io = io
local string = string
local math = math

module("memory")

function memory_usage(color1, color2)
  local memtotal = nil
  local memcached = nil
  local membuffered = nil
  local memfree = nil
  for line in io.lines("/proc/meminfo") do
    local kind, str= string.match(line, "(.+):\ +(%d+)\ kB")
    if kind == "MemTotal" and str then
      memtotal = str
    end
    if kind == "MemFree" and str then
      memfree = str
    end
    if kind == "Buffers" and str then
      membuffered = str
    end
    if kind == "Cached" and str then
      memcached = str
    end
  end
  local memused = math.floor((memtotal - memfree - memcached - membuffered) / 1024)
  memtotal = math.floor(memtotal / 1024)
  mem = string.format("%02d", math.floor((memused / memtotal) * 100)) .. "% "
  mem = mem .. string.format("[%d/%d]", memused, memtotal)
  s = " <span color='" .. color1 .. "'>mem:</span> "
  s = s .. "<span color='" .. color2 .. "'>" .. mem .. "</span> "
  return s
end

