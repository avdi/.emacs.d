;; chruby to manage ruby verrsions
(prelude-require-package 'chruby)
(prelude-require-package 'enh-ruby-mode)
(prelude-require-package 'ruby-mode)
(prelude-require-package 'ruby-additional)

(add-to-list 'auto-mode-alist '("\\.rb$" . enh-ruby-mode))
(add-to-list 'interpreter-mode-alist '("ruby" . enh-ruby-mode))
(add-to-list 'org-babel-load-languages
             '("ruby" . enh-ruby-mode))

(add-to-list 'org-src-lang-modes '("ruby" . enh-ruby))
(require 'cl)
(require 'chruby)
(chruby "2.1.3")

;; (setq xmpfilter-command-name
;;       "ruby -S xmpfilter --no-warnings --dev --fork --detect-rbtest")
(setq xmpfilter-command-name
      "ruby -S seeing_is_believing --xmpfilter-style -d 80")

(require 'rcodetools)

;; Tweak the usual rcodetools comment-dwim hack to also work in
;; enh-ruby-mode
(ad-disable-advice 'comment-dwim 'around 'rct-hack)
(ad-update 'comment-dwim)
(defadvice comment-dwim (around rct-hack activate)
  "If comment-dwim is successively called, add => mark."
  (if (and (member major-mode '(ruby-mode enh-ruby-mode))
           (eq last-command 'comment-dwim))
      (insert "=>")
    ad-do-it))

(eval-after-load 'ruby-mode
  '(progn
     (define-key ruby-mode-map (kbd "C-c C-c") 'xmp)))

(eval-after-load 'enh-ruby-mode
  '(progn
     (define-key enh-ruby-mode-map (kbd "C-c C-c") 'xmp)))

(add-to-list 'org-babel-tangle-lang-exts '("ruby" . "rb"))

(prelude-require-package 'rspec-mode)

;; setup align for ruby-mode
;; yoinked from https://github.com/defunkt/emacs/blob/master/vendor/ruby-hacks.el
(require 'align)

(defconst align-ruby-modes '(ruby-mode)
  "align-perl-modes is a variable defined in `align.el'.")

(defconst ruby-align-rules-list
  '((ruby-comma-delimiter
     (regexp . ",\\(\\s-*\\)[^/ \t\n]")
     (modes  . align-ruby-modes)
     (repeat . t))
    (ruby-string-after-func
     (regexp . "^\\s-*[a-zA-Z0-9.:?_]+\\(\\s-+\\)['\"]\\w+['\"]")
     (modes  . align-ruby-modes)
     (repeat . t))
    (ruby-symbol-after-func
     (regexp . "^\\s-*[a-zA-Z0-9.:?_]+\\(\\s-+\\):\\w+")
     (modes  . align-ruby-modes)))
  "Alignment rules specific to the ruby mode.
See the variable `align-rules-list' for more details.")

(add-to-list 'align-perl-modes 'ruby-mode)
(add-to-list 'align-dq-string-modes 'ruby-mode)
(add-to-list 'align-sq-string-modes 'ruby-mode)
(add-to-list 'align-open-comment-modes 'ruby-mode)
(dolist (it ruby-align-rules-list)
  (add-to-list 'align-rules-list it))
