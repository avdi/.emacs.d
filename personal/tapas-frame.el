(prelude-require-package 'centered-cursor-mode)
(prelude-require-package 'rainbow-delimiters)

(defun make-rubytapas-frame ()
  (interactive)

  (require 'centered-cursor-mode)
  (let* ((frame-alist '((fullscreen . maximized)
                        (menu-bar-lines . 0)
                        (name . "RubyTapas")))
         (frame (make-frame frame-alist)))
    (select-frame frame)
    (set-frame-font "Inconsolata:pixelsize=24:foundry=unknown:weight=normal:slant=normal:width=normal:spacing=100:scalable=true" nil)
    (switch-to-buffer "RubyTapas")
    (enh-ruby-mode)
    (whitespace-mode -1)
    (menu-bar-mode -1)
    ;; (set (make-local-variable 'xmpfilter-command-name)
    ;;      "ruby -S xmpfilter --no-warnings --dev --fork --detect-rbtest")
    (if (featurep 'fci-mode)
        (fci-mode -1))
    (set (make-local-variable 'fill-column) 80)
    (rainbow-delimiters-mode 1)
    (centered-cursor-mode 1)
    ;; Why the hell doesn't this "take" in the color theme???
    (set-face-attribute 'hl-line-face
                        frame
                        :background "#293739"
                        :inherit nil)

    (hl-line-mode 1)
    (local-set-key (kbd "<f8>") 'abg-slow-playback)
    (local-set-key (kbd "<f9>") 'rubytapas-xscribble)))

(defun rubytapas-xscribble ()
  (interactive)
  (let ((window-id (frame-parameter nil 'outer-window-id)))
    (start-process-shell-command "XScribble" "*XScribble*" (concat "/usr/local/bin/Xscribble " window-id " &"))))

