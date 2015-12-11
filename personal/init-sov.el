(defun abg-save-buffer-if-valid ()
  (let ((errors
         (remove-if
          (lambda (e)
            (eq 'warning (flycheck-error-level e)))
          flycheck-current-errors)))
    (when (null errors) (save-buffer))))

(define-minor-mode abg-save-on-valid-mode
  "Save buffer anytime it is free of flycheck errors"
  :lighter " SoV"
  (cond (abg-save-on-valid-mode
         (add-hook 'flycheck-after-syntax-check-hook
                   'abg-save-buffer-if-valid))
        (t
         (remove-hook 'flycheck-after-syntax-check-hook
                      'abg-save-buffer-if-valid))))
