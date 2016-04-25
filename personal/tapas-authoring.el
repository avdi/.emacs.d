;;; customizations for authoring Tapas scripts

(defun rubytapas-file-title ()
  (capitalize
   (replace-regexp-in-string
    "[^[:alnum:]]+" " "
    (replace-regexp-in-string
     "[0-9x]\\{3\\}-" ""
     (file-name-sans-extension
      (file-name-nondirectory buffer-file-name))))))


(defun rubytapas-insert-episode-boilerplate ()
  (insert "rtscript")
  (yas-expand))

(setq rubytapas-dir
      (pcase system-name
        ("CAROLINE"
         (concat (getenv "USERPROFILE") "\\Dropbox\\rubytapas"))
        ("hazel"
         (expand-file-name "~/Dropbox/rubytapas"))
        ("tapasvm2015"
         (expand-file-name "/media/sf_rubytapas"))
        (_
         (display-warning :warning "Did not recognize system")
         (expand-file-name "~/Dropbox/rubytapas"))))

(defun rubytapas-auto-insert ()
  (if (equal (string-match
              (regexp-quote (convert-standard-filename rubytapas-dir))
              (convert-standard-filename (buffer-file-name)))
             0)
      (rubytapas-insert-episode-boilerplate)))

(eval-after-load "autoinsert"
  '(add-to-list 'auto-insert-alist
                '(org-mode . rubytapas-auto-insert)))

(defun rubytapas-xscribble ()
  (interactive)
  (let ((window-id (frame-parameter nil 'outer-window-id)))
    (start-process-shell-command "XScribble" "*XScribble*" (concat "/usr/local/bin/Xscribble " window-id " &"))))

(provide 'tapas-authoring)

;;; tapas-authoring ends herev
