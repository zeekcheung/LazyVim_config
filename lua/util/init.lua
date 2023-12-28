local M = {}

-- Get current season
function M.current_season()
  local os = require("os")
  local currentMonth = tonumber(os.date("%m"))
  local seasons = { "winter", "spring", "summer", "autumn" }

  return seasons[math.floor((currentMonth % 12) / 3) + 1]
end

return M
