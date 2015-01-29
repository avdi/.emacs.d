(defun abg-suspend-frame-suppress-iconify (orig-fun &rest args)
  "Suppress C-z iconification in window systems"
  (unless (memq (framep (selected-frame)) '(x ns w32))
    (apply orig-fun args)))

(advice-add 'suspend-frame :around #'abg-suspend-frame-suppress-iconify)
    
