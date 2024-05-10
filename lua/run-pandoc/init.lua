local M = {}

function M.setup() end

function M.compile()
	local supported_filetypes = { "markdown", "rst", "html", "latex", "docx", "org" }
	local buf_filetype = vim.api.nvim_buf_get_option(0, "filetype")

	local found = false
	for k in pairs(supported_filetypes) do
		if buf_filetype == supported_filetypes[k] then
			found = true
		end
	end

	if not found then
		print("run_pandoc: Not a supported filetype")
		return
	end

	local buf_name = vim.api.nvim_buf_get_name(0)
	local buf_name_pdf_ext = buf_name:match("(.+)%..+") .. ".pdf"

	local output = vim.fn.system(string.format("pandoc %s -o %s 2>&1", buf_name, buf_name_pdf_ext))
	print(output)

	if vim.v.shell_error == 0 then
		print("run_pandoc: Compiled successfully to " .. buf_name_pdf_ext)
	else
		vim.api.nvim_echo({ { output } }, true, {})
	end
end

return M
