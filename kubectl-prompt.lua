function kubectl_prompt_filter()
    local ns = "default"
--    local p = io.popen("kubectl config view --minify 2>nul", "rt")
    local p = io.popenyield("cmd /D /C kubectl config view --minify 2>nul", "rt")
    for line in p:lines() do
        local m = line:match(" *namespace: (.+)$")
        if m then
          ns = m
          break
        end
    end
    p:close()
    p = io.popenyield("cmd /D /C kubectl config current-context 2>nul", "rt")
    for line in p:lines() do
        local m = line:match("(.+)$")
        if m then
--            clink.prompt.value = "\027[30;42m"..m.."\027[32;40m\027[42m "..clink.prompt.value
            clink.prompt.value = "\027[30;42m ☸ "..m..":"..ns.."\027[32m"..clink.prompt.value

-- commands would randomly hang.  possibly not draining the output
            break
        end
    end
    p:close()
    return false
end

clink.prompt.register_filter(kubectl_prompt_filter, 60)