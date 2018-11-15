---
 -- Checks if the specified directory is inside a git repo.
 -- Navigates subsequently up one level and tries to find specified directory
 -- @param  {string} path    Path to directory will be checked.
 -- @return {bool} Path to specified directory or nil if such dir not found

local function isGitRepo(path)

    -- return parent path for specified entry (either file or directory)
    local function pathname(path)
        local prefix = ""
        local i = path:find("[\\/:][^\\/:]*$")
        if i then
            prefix = path:sub(1, i-1)
        end
        return prefix
    end

    -- Navigates up one level
    local function up_one_level(path)
        if path == nil then path = '.' end
        if path == '.' then path = clink.get_cwd() end
        return pathname(path)
    end

    -- Checks if provided directory contains git directory
    local function has_specified_dir(path, specified_dir)
        if path == nil then path = '.' end
        local found_dirs = clink.find_dirs(path..'/'..specified_dir)
        if #found_dirs > 0 then return true end
        return false
    end

    if has_specified_dir(path, ".git") then
        return true
    else
        -- Otherwise go up one level and make a recursive call
        local parent_path = up_one_level(path)
        if parent_path == path then
            return false
        else
            return isGitRepo(parent_path)
        end
    end
end


function git_prompt_filter()
    if isGitRepo(".") then
        for line in io.popen("git branch 2>nul"):lines() do
            local m = line:match("%* (.+)$")
            if m then
--                 clink.prompt.value = "\027[30;41m  "..m.."\027[31;49m\027[39;49m "..clink.prompt.value
                clink.prompt.value = "\027[41m\027[30m  "..m.." \027[31m\027[40m"..clink.prompt.value
-- commands would seeming hang, -- lets see if it is waiting to read extra lines...
--                 break
            end
        end
    end
    return false
end



clink.prompt.register_filter(git_prompt_filter, 50)