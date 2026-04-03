-- Voice transcription integration for Neovim (Terminal version)
-- This opens a terminal where you can press ENTER to stop recording

local M = {}

-- Path to your listen script
local LISTEN_SCRIPT = "transcribe-me"

function M.listen_and_insert()
    -- Save the current buffer and window
    local original_buf = vim.api.nvim_get_current_buf()
    local original_win = vim.api.nvim_get_current_win()
    
    -- Create a temporary file for output
    local tmp_file = vim.fn.tempname()
    
    -- Create a new split for the terminal
    vim.cmd('split')
    local term_win = vim.api.nvim_get_current_win()
    
    -- Resize to smaller height
    vim.api.nvim_win_set_height(term_win, 5)
    
    -- Start terminal with the script, redirecting output to temp file
    local term_buf = vim.api.nvim_create_buf(false, true)
    vim.api.nvim_win_set_buf(term_win, term_buf)
    
    local job_id = vim.fn.termopen("bash " .. LISTEN_SCRIPT .. " | tee " .. tmp_file, {
        on_exit = function(_, exit_code)
            -- Close the terminal window
            vim.schedule(function()
                if vim.api.nvim_win_is_valid(term_win) then
                    vim.api.nvim_win_close(term_win, true)
                end
                
                -- Go back to original window
                if vim.api.nvim_win_is_valid(original_win) then
                    vim.api.nvim_set_current_win(original_win)
                end
                
                if exit_code == 0 then
                    -- Read the transcription from temp file
                    local file = io.open(tmp_file, "r")
                    if file then
                        local transcription = file:read("*a")
                        file:close()
                        
                        transcription = transcription:gsub("^%s*(.-)%s*$", "%1")
                        
                        if transcription and #transcription > 0 then
                            -- Insert at cursor position in original buffer
                            local lines = vim.split(transcription, "\n")
                            vim.api.nvim_put(lines, "c", true, true)
                            vim.notify("Transcription inserted!", vim.log.levels.INFO)
                        else
                            vim.notify("No transcription generated", vim.log.levels.WARN)
                        end
                    end
                else
                    vim.notify("Recording failed", vim.log.levels.ERROR)
                end
                
                -- Clean up temp file
                os.remove(tmp_file)
            end)
        end,
    })
    
    -- Enter insert mode in terminal so user can press ENTER
    vim.cmd('startinsert')
end

-- Create the command
vim.api.nvim_create_user_command("Listen", M.listen_and_insert, {})

-- Optional keymaps
vim.keymap.set("n", "<leader>l", M.listen_and_insert, { desc = "Voice transcription" })

return M
