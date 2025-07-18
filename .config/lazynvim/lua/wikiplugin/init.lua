local m = {}

local function get_current_file()
  return vim.api.nvim_buf_get_name(0)
end

local function get_current_line_number()
  return vim.api.nvim_win_get_cursor(0)[1]
end

local function get_current_date()
  return os.date("%Y-%m-%d")
end

local function get_latest_commit_hash()
  local cmd = "git log -1 --pretty=format:%H"
  local handle = io.popen(cmd)
  local result = handle:read("*a")
  handle:close()
  return result
end

local function create_note()
  local file_name = get_current_file()
  local line = get_current_line_number()
  local date = get_current_date()
  local commit = get_latest_commit_hash()
  local note = string.format("date: %s\nhash: %s\nline num: %s\nfile: %s", date, commit, line, file_name)

  vim.cmd("new")
  vim.api.nvim_put({ note }, "l", false, true)
  vim.api.nvim_buf_set_lines(0, 0, -1, false, vim.split(note, "\n"))
end

function m.setup()
  vim.api.nvim_create_user_command("Wikinote", create_note, {})
  print("Wikiplugin completed setup")
end

return m
