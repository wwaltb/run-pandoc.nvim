local run_pandoc = {}

-- Check if a filetype is from the list of supported filetypes
-- @param filetype: The filetype to check
local function supported_filetype(filetype)
    local supported_filetypes = { "markdown", "rst", "html", "latex", "docx", "org" }

    for k in pairs(supported_filetypes) do
        if filetype == supported_filetypes[k] then
            return true
        end
    end

    return false
end

function run_pandoc.compile()
    -- check if current buffer is of a supported filetype
    local filetype = vim.api.nvim_buf_get_option(0, "filetype")
    if not supported_filetype(filetype) then
        print("run_pandoc: Not a supported filetype")
        return
    end

    -- run pandoc on the current buffer
    local buf_name = vim.api.nvim_buf_get_name(0)
    local buf_name_pdf_ext = buf_name:match("(.+)%..+") .. ".pdf"

    local options = "--variable colorlinks=true"
    local command = string.format("pandoc %s -o %s %s 2>&1", buf_name, buf_name_pdf_ext, options)

    local output = vim.fn.system(command)

    -- print output on error
    if vim.v.shell_error == 0 then
        print("run_pandoc: Compiled successfully to " .. buf_name_pdf_ext)
    else
        vim.api.nvim_echo({ { output } }, true, {})
    end
end

return run_pandoc
