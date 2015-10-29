;; The elisp checkdoc warnings are a bit overbearing
(with-eval-after-load 'flycheck
  (setq-default flycheck-disabled-checkers '(emacs-lisp-checkdoc)))
