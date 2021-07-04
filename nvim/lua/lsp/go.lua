require('go').setup({
    goimport='gofumports',
    gofmt = 'gofumpt',
    max_len = 120,
    transform = false,
    test_template = '',
    test_template_dir = '',
    comment_placeholder = '' ,
    verbose = false,
})

require'dap'.adapters.go = function(callback, config)
    local handle
    local pid_or_err
    local port = 38697
    handle, pid_or_err = vim.loop.spawn( "dlv", {
        args = {"dap", "-l", "127.0.0.1:" .. port},
        detached = true
    },
    function(code)
        handle:close()
        print("Delve exited with exit code: " .. code)
    end
    )
    -- Wait 100ms for delve to start
    vim.defer_fn(function()
        callback({type = "server", host = "127.0.0.1", port = port})
    end,
    100)
    --callback({type = "server", host = "127.0.0.1", port = port})
end

require'dap'.configurations.go = {
    {
        type = "go",
        name = "Debug",
        request = "launch",
        program = "${file}"
    },
    {
        type = "go",
        name = "Debug test",
        request = "launch",
        mode = "test",
        program = "${file}"
    },
}

