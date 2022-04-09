return {
	-- use find_files if git_files can't find a .git directory
	files = function()
		local ok = pcall(require('telescope.builtin').git_files)
		if not ok then require('telescope.builtin').find_files() end
	end
}
