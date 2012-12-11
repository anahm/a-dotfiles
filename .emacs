(custom-set-variables
  ;; custom-set-variables was added by Custom.
  ;; If you edit it by hand, you could mess it up, so be careful.
  ;; Your init file should contain only one such instance.
  ;; If there is more than one, they won't work right.
 )
(custom-set-faces
  ;; custom-set-faces was added by Custom.
  ;; If you edit it by hand, you could mess it up, so be careful.
  ;; Your init file should contain only one such instance.
  ;; If there is more than one, they won't work right.
 )

(add-to-list 'load-path "/Users/anahm")

;; insert spaces instead of tabs
(setq-default indent-tabs-mode nil)

;; change indent-line-function - change to insert tab into 4 spaces
;; than change it to insert 4 spaces
(setq-default tab-width 4)
(setq indent-line-function 'insert-tab)

;; show column numbers
(column-number-mode t)

;; show matching parens
(show-paren-mode 1)

;; show time
(display-time)

;; enable mouse clicking in emacs
(require 'mouse)
(xterm-mouse-mode t)
(defun track-mouse (e))
(setq mouse-sel-mode t)

;; tuareg mode
(add-to-list 'load-path "~/.emacs.d/tuareg-2.0.4")
(setq auto-mode-alist 
      (append '(("\\.ml[ily]?$" . tuareg-mode)
        ("\\.topml$" . tuareg-mode))
          auto-mode-alist))
(autoload 'tuareg-mode "tuareg" "Major mode for editing Caml code" t)
(autoload 'camldebug "camldebug" "Run the Caml debugger" t)

;; see what block of code you're highlighting
(transient-mark-mode t)

;; line numbers
(add-to-list 'load-path "~/.emacs.d")
(require 'linum)
(global-linum-mode 1)

;; directory tree views
(autoload 'dirtree "dirtree" "Add directory to tree view" t)

;; highlight characters beyond column 80
(require 'highlight-80+)
(add-hook 'find-file-hook 'highlight-80+-mode)

;; a mode to manage tree widgets
(require 'tree-mode)

;; delete extra whitespace
(defun duplicate-line (arg)
  "Duplicate current line, leaving point in lower line."
  (interactive "*p")
  ;; save the point for undo
  (setq buffer-undo-list (cons (point) buffer-undo-list))
  ;; local variables for start and end of line
  (let ((bol (save-excursion (beginning-of-line) (point)))
        eol)
    (save-excursion
        ;; don't use forward-line for this, because you would have
        ;; to check whether you are at the end of the buffer
        (end-of-line)
        (setq eol (point))
        ;; store the line and disable the recording of undo info
        (let ((line (buffer-substring bol eol))
            (buffer-undo-list t)
            (count arg))
          ;; insert the line arg times
          (while (> count 0)
            (newline)           ;; because no newline in 'line'
            (insert line)
            (setq count (1- count)))
          )
        ;; create the undo info
        (setq buffer-undo-list (cons (cons eol (point)) buffer-undo-list)))
      ) ; end-of-let
    ;; put the point in the lowest line and return
    (next-line arg))

;; color theme
(add-to-list 'load-path "~/.emacs.d/color-theme-6.6.0")
(add-to-list 'load-path "~/.emacs.d/emacs-color-theme-solarized")
(require 'color-theme-solarized)
;; (color-theme-solarized-dark)

;; emacs transperency background functions
;; (set-frame-parameter (selected-frame) 'alpha '(<active> [<inactive>]))
(set-frame-parameter (selected-frame) 'alpha '(85 50))
(add-to-list 'default-frame-alist '(alpha 85 50))

(eval-when-compile (require 'cl))
(defun toggle-transparency ()
    (interactive)
    (if (/=
        (cadr (frame-parameter nil 'alpha))
        100)
        (set-frame-parameter nil 'alpha '(100 100))
    (set-frame-parameter nil 'alpha '(85 50))))
(global-set-key (kbd "C-c t") 'toggle-transparency)
