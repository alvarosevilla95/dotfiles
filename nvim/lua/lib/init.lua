lib = {}

require 'lib.F'
require 'lib.log'

lib.urlencode = function(url)
    local char_to_hex = function(c)
        return string.format("%%%02X", string.byte(c))
    end
    if url == nil then
        return
    end
    url = url:gsub("\n", "\r\n")
    url = url:gsub("([^%w ])", char_to_hex)
    url = url:gsub(" ", "+")
    return url
end

lib.iprint = function(obj)
    print(vim.inspect(obj))
end

lib.split = function(s, sep)
    local t = {}
    if sep == nil then
        sep = "%s"
    end
    for str in string.gmatch(s, "([^"..sep.."]+)") do
        table.insert(t, str)
    end
    return t
end

lib.size = function(T)
  local count = 0
  for _ in pairs(T) do count = count + 1 end
  return count
end
