local M = {}

function M.setup() end

function M.run()
   local buf_file_type = vim.api.nvim_buf_get_option(0, "filetype")
   if buf_file_type ~= "markdown" then
      print("run_pandoc: Not a markdown file")
      return
   end


   local buf_name = vim.api.nvim_buf_get_name(0)
   local buf_name_pdf_ext = buf_name:match("(.+)%..+") .. ".pdf"

   local output = vim.fn.system(string.format("pandoc %s -o %s", buf_name, buf_name_pdf_ext))

   if vim.v.shell_error == 0 then
      print("run_pandoc: Compiled successfully to " .. buf_name_pdf_ext)
   else
      print("run_pandoc: Error - " .. output)
   end
end

return M
