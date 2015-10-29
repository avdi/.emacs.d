(prelude-require-packages
 '(monokai-theme
   molokai-theme
   moe-theme))

(load-theme 'monokai)

(prelude-require-packages '(smart-mode-line))

(setq sml/theme 'respectful)
(sml/setup)
