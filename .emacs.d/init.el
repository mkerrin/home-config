;; Start emacs server.

;; Added by Package.el.  This must come before configurations of
;; installed packages.  Don't delete this line.  If you don't want it,
;; just comment it out by adding a semicolon to the start of the line.
;; You may delete these explanatory comments.
(package-initialize)

;; Package
(require 'package)
(add-to-list 'package-archives
             '("melpa" . "https://melpa.org/packages/") t)

(server-start)

;; set up ido mode
(require `ido)
;(setq ido-enable-flex-matching t)
;(setq ido-everywhere t)
(ido-mode 1)

(if (fboundp 'scroll-bar-mode) (scroll-bar-mode -1))
(if (fboundp 'tool-bar-mode) (tool-bar-mode -1))
(if (fboundp 'menu-bar-mode) (menu-bar-mode 1))

;; set up org mode
; (setq org-startup-indented t)
(setq org-startup-folded "showall")
(setq org-directory "~/org")

;; elpy
;(use-package elpy
;	     :ensure t
;	     :init
;	     (elpy-enable))
(elpy-enable)
; (remove-hook 'flymake-diagnostic-functions 'flymake-proc-legacy-flymake)

; (add-to-list 'process-coding-system-alist '("python" . (utf-8 . utf-8)))
(setq elpy-rpc-python-command "python3")

(require 'flycheck-pyflakes)
(add-hook 'python-mode-hook 'flycheck-mode)

;(add-to-list 'process-coding-system-alist '("python" . (utf-8 . utf-8)))
;(setenv "PYTHONIOENCODING" "utf-8")
;(add-to-list 'process-coding-system-alist '("python" . (utf-8 . utf-8)))
;(add-to-list 'process-coding-system-alist '("elpy" . (utf-8 . utf-8)))
;(add-to-list 'process-coding-system-alist '("flake8" . (utf-8 . utf-8)))

;; latex-math-preview

(define-key global-map (kbd "M-l") 'math-preview-all)
(define-key global-map (kbd "M-r") 'math-preview-region)
(define-key global-map (kbd "M-p") 'latex-math-preview-expression)
; (define-key (kbd "\C-p") 'latex-math-preview-save-image-file)
; (define-key (kbd "j") 'latex-math-preview-insert-symbol)
; (define-key (kbd "\C-j") 'latex-math-preview-last-symbol-again)
; (define-key (kbd "\C-b") 'latex-math-preview-beamer-frame)

(add-hook 'org-mode-hook 'org-fragtog-mode)

(require 'org)
(setq org-format-latex-options (plist-put org-format-latex-options :scale 1.50))
