require("zoxide"):setup({ update_db = true })
require("relative-motions"):setup({ show_numbers = "relative", show_motion = true, enter_mode = "first" })
require("yaziline"):setup()
require("mime-ext"):setup({
	-- Expand the existing filename database (lowercase), for example:
	with_files = {
		makefile = "text/makefile",
		-- ...
	},

	-- Expand the existing extension database (lowercase), for example:
	with_exts = {
		mk = "text/makefile",
		-- ...
	},

	-- If the mime-type is not in both filename and extension databases,
	-- then fallback to Yazi's preset `mime` plugin, which uses `file(1)`
	fallback_file1 = true,
})

