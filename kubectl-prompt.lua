function kubectl_prompt_filter()
    for line in io.popen("kubectl config current-context 2>nul"):lines() do
        local m = line:match("(.+)$")
        if m then
--            clink.prompt.value = "\027[30;42m"..m.."\027[32;40m\027[42m "..clink.prompt.value
            clink.prompt.value = "\027[30;42m"..m.."\027[32m"..clink.prompt.value
-- commands would randomly hang.  possibly not draining the output
--            break
        end
    end

    return false
end

clink.prompt.register_filter(kubectl_prompt_filter, 60)