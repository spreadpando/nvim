-- lua/windows.lua
local M = {}

-- ============================================================================
-- STATE
-- ============================================================================
local bottom_win = nil -- pinned bottom panel window
local main_win = nil -- main code window
local bottom_height = 15

-- ============================================================================
-- UTILITIES
-- ============================================================================
local function ensure_main_win()
  if not main_win or not vim.api.nvim_win_is_valid(main_win) then
    main_win = vim.api.nvim_get_current_win()
  end
end

local function get_loaded_buffers()
  local bufs = {}
  for _, buf in ipairs(vim.fn.getbufinfo({ bufloaded = 1 })) do
    table.insert(bufs, buf.bufnr)
  end
  return bufs
end

local function is_terminal(buf)
  return vim.bo[buf].buftype == "terminal"
end

-- ============================================================================
-- TERMINAL LAUNCH
-- ============================================================================
function M.launch_terminal()
  ensure_main_win()

  -- Create bottom split if missing
  if not bottom_win or not vim.api.nvim_win_is_valid(bottom_win) then
    vim.api.nvim_set_current_win(main_win)
    vim.cmd("botright split")
    bottom_win = vim.api.nvim_get_current_win()
    vim.cmd("resize " .. bottom_height)
  end

  -- Focus bottom panel
  vim.api.nvim_set_current_win(bottom_win)

  -- Replace buffer with new terminal
  local buf = vim.api.nvim_create_buf(true, false)
  vim.api.nvim_win_set_buf(bottom_win, buf)
  vim.cmd("terminal")
end

-- Launch a Claude "terminal" buffer in the bottom panel
function M.launch_claude()
  ensure_main_win()

  -- Create bottom panel if missing
  if not bottom_win or not vim.api.nvim_win_is_valid(bottom_win) then
    vim.api.nvim_set_current_win(main_win)
    vim.cmd("botright split")
    bottom_win = vim.api.nvim_get_current_win()
    vim.cmd("resize " .. bottom_height)
  end

  -- Focus bottom panel
  vim.api.nvim_set_current_win(bottom_win)

  -- Create a buffer for Claude (replace existing buffer)
  local buf = vim.api.nvim_create_buf(true, false)
  vim.api.nvim_win_set_buf(bottom_win, buf)

  -- Start Claude as a terminal process
  -- Adjust "claude" to whatever shell command starts the Claude chatbot CLI
  vim.fn.termopen("claude")

  -- Optional: enter insert mode automatically
  vim.cmd("startinsert")
end

-- ============================================================================
-- BUFFER NAVIGATION
-- ============================================================================
function M.next_buffer()
  local cur_win = vim.api.nvim_get_current_win()
  local cur_buf = vim.api.nvim_get_current_buf()

  if cur_win == bottom_win then
    -- Bottom panel: cycle only terminal buffers
    local term_bufs = {}
    for _, buf in ipairs(get_loaded_buffers()) do
      if is_terminal(buf) then
        table.insert(term_bufs, buf)
      end
    end
    if #term_bufs == 0 then
      return
    end
    local idx = 1
    for i, buf in ipairs(term_bufs) do
      if buf == cur_buf then
        idx = i
        break
      end
    end
    local next_idx = (idx % #term_bufs) + 1
    vim.api.nvim_set_current_buf(term_bufs[next_idx])
  else
    -- Main panel: skip terminal buffers

    local non_term_bufs = {}
    for _, buf in ipairs(get_loaded_buffers()) do
      local name = vim.api.nvim_buf_get_name(buf)
      local is_minimap = name:match("minimap") -- exclude MiniMap buffer
      if not is_terminal(buf) and vim.bo[buf].filetype ~= "NvimTree" and not is_minimap then
        table.insert(non_term_bufs, buf)
      end
    end

    if #non_term_bufs == 0 then
      return
    end
    local idx = 1
    for i, buf in ipairs(non_term_bufs) do
      if buf == cur_buf then
        idx = i
        break
      end
    end
    local next_idx = (idx % #non_term_bufs) + 1
    vim.api.nvim_set_current_buf(non_term_bufs[next_idx])
  end
end

function M.prev_buffer()
  local cur_win = vim.api.nvim_get_current_win()
  local cur_buf = vim.api.nvim_get_current_buf()

  if cur_win == bottom_win then
    local term_bufs = {}
    for _, buf in ipairs(get_loaded_buffers()) do
      if is_terminal(buf) then
        table.insert(term_bufs, buf)
      end
    end
    if #term_bufs == 0 then
      return
    end
    local idx = 1
    for i, buf in ipairs(term_bufs) do
      if buf == cur_buf then
        idx = i
        break
      end
    end
    local prev_idx = ((idx - 2 + #term_bufs) % #term_bufs) + 1
    vim.api.nvim_set_current_buf(term_bufs[prev_idx])
  else
    local non_term_bufs = {}
    for _, buf in ipairs(get_loaded_buffers()) do
      local name = vim.api.nvim_buf_get_name(buf)
      local is_minimap = name:match("minimap") -- exclude MiniMap buffer
      if not is_terminal(buf) and vim.bo[buf].filetype ~= "NvimTree" and not is_minimap then
        table.insert(non_term_bufs, buf)
      end
    end
    if #non_term_bufs == 0 then
      return
    end
    local idx = 1
    for i, buf in ipairs(non_term_bufs) do
      if buf == cur_buf then
        idx = i
        break
      end
    end
    local prev_idx = ((idx - 2 + #non_term_bufs) % #non_term_bufs) + 1
    vim.api.nvim_set_current_buf(non_term_bufs[prev_idx])
  end
end

-- Toggle focus between main window and bottom terminal panel
function M.toggle_main_bottom()
  if not main_win or not vim.api.nvim_win_is_valid(main_win) then
    return
  end
  if not bottom_win or not vim.api.nvim_win_is_valid(bottom_win) then
    return
  end

  local cur_win = vim.api.nvim_get_current_win()
  if cur_win == main_win then
    vim.api.nvim_set_current_win(bottom_win)
  else
    vim.api.nvim_set_current_win(main_win)
  end
end

-- Attach auto-reload watcher to a single buffer
local function watch_buffer(buf)
  if is_terminal(buf) then
    return
  end
  vim.api.nvim_buf_attach(buf, false, {
    on_lines = function()
      if not vim.bo[buf].modified then
        vim.cmd("silent! checktime")
      end
    end,
  })
end

-- Attach to all currently loaded buffers
for _, buf in ipairs(get_loaded_buffers()) do
  watch_buffer(buf)
end

-- Autocmd to attach watcher for any new buffer opened later
vim.api.nvim_create_autocmd({ "BufReadPost", "BufNewFile" }, {
  pattern = "*",
  callback = function(ev)
    watch_buffer(ev.buf)
  end,
})

-- ============================================================================
-- SIMPLE BOTTOM PANEL TOGGLE
-- ============================================================================

local last_bottom_buf = nil

local function close_bottom_panel()
  if bottom_win and vim.api.nvim_win_is_valid(bottom_win) then
    last_bottom_buf = vim.api.nvim_win_get_buf(bottom_win)
    vim.api.nvim_win_close(bottom_win, false)
    bottom_win = nil
  end
end

local function open_bottom_panel()
  ensure_main_win()

  vim.api.nvim_set_current_win(main_win)
  vim.cmd("botright split")
  bottom_win = vim.api.nvim_get_current_win()
  vim.cmd("resize " .. bottom_height)

  if last_bottom_buf and vim.api.nvim_buf_is_valid(last_bottom_buf) then
    vim.api.nvim_win_set_buf(bottom_win, last_bottom_buf)
  end
end

function M.toggle_bottom_panel()
  if bottom_win and vim.api.nvim_win_is_valid(bottom_win) then
    close_bottom_panel()
  else
    open_bottom_panel()
  end
end

return M
