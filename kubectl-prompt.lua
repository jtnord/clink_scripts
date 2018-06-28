function kubectl_prompt_filter()
    for line in io.popen("kubectl config current-context 2>nul"):lines() do
        local m = line:match("(.+)$")
        if m then
            clink.prompt.value = "["..m.."] "..clink.prompt.value
            break
        end
    end

    return false
end

clink.prompt.register_filter(kubectl_prompt_filter, 60)