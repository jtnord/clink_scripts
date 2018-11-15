---
 -- Checks if the specified directory is inside a git repo.
 -- Navigates subsequently up one level and tries to find specified directory
 -- @param  {string} path    Path to directory will be checked.
 -- @return {bool} Path to specified directory or nil if such dir not found

function git_prompt_filter()  
    clink.prompt.value = "\027[40m\027[49m\027[39m "..clink.prompt.value
    return false
end



clink.prompt.register_filter(git_prompt_filter, 10)