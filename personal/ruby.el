;; chruby to manage ruby verrsions
(prelude-require-package 'chruby)
(prelude-require-package 'enh-ruby-mode)
(prelude-require-package 'ruby-mode)

(add-to-list 'auto-mode-alist '("\\.rb$" . enh-ruby-mode))
(add-to-list 'interpreter-mode-alist '("ruby" . enh-ruby-mode))
(add-to-list 'org-babel-load-languages
             '("ruby" . enh-ruby-mode))


(require 'cl)
(require 'chruby)
(chruby "2.1.2")

;; rcodetools to eval ruby in-buffer
(setq rcodetools-dir
      (expand-file-name "../../.."
                        (replace-regexp-in-string
                         "\n$" ""
                         (shell-command-to-string
                          "gem which rcodetools/xmpfilter"))))
(add-to-list 'load-path
             rcodetools-dir)
;; (setq xmpfilter-command-name
;;       "ruby -S xmpfilter --no-warnings --dev --fork --detect-rbtest")
(setq xmpfilter-command-name
      "ruby -S seeing_is_believing --xmpfilter-style")

(eval-after-load 'ruby-mode
  '(progn
     (require 'rcodetools)
     (define-key ruby-mode-map (kbd "C-c C-c") 'xmp)))

(eval-after-load 'enh-ruby-mode
  '(progn
     (require 'rcodetools)
     (define-key enh-ruby-mode-map (kbd "C-c C-c") 'xmp)))

(add-to-list 'org-babel-tangle-lang-exts '("ruby" . "rb"))
