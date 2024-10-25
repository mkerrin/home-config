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


;; elpy - python integration
;(use-package elpy
;	     :ensure t
;	     :init
;	     (elpy-enable))
; (elpy-enable)

;; Copied from https://gist.github.com/TauPan/17305751a883005872dc
;; replace nose -> pytest
(use-package elpy
  :config
  (progn (elpy-enable)
	 (defun elpy-pytest-test-spec (module test)
           (cond (test
		  (let ((test-list (split-string test "\\."))
			(module-list (split-string module "\\."))
			)
		    (let ((mod (mapconcat #'identity module-list "/")))
		      (mapconcat #'identity
				 (cons (format "%s.py" mod) test-list)
				 "::")
		      )
		    )
		  )
                 (module module)
                 (t "")))
         (defun elpy-test-nose-pdb-runner (top file module test)
           "Test the project using the nose test runner with the --pdb arg.
This requires the nose package to be installed."
           (interactive (elpy-test-at-point))
           (let ((default-directory top))
             (pdb (format "pytest --rootdir %s -vv --pdb %s"
                          top (elpy-pytest-test-spec module test)))))
         (put 'elpy-test-nose-pdb-runner 'elpy-test-runner-p t)
         (defvar elpy-test-pdb-runner
           #'elpy-test-nose-pdb-runner
           "Test runner to run with pdb")
         (defun elpy-test-django-nose-pdb-runner (top file module test)
           "Test the project using the django-nose test runner with the --pdb arg.
This requires the django-nose package to be installed and
properly configured for the django project."
           (interactive (elpy-test-at-point))
           (let ((default-directory top))
             (pdb (format "django-admin.py test --noinput %s --pdb"
                          (elpy-nose-test-spec module test)))))
         (defun elpy-test-pdb (&optional test-whole-project)
           "Run test the current project with the elpy-test-pdb-runner
            prefix args have the same semantics as for `elpy-test'"
           (interactive "P")
           (let ((elpy-test-runner elpy-test-pdb-runner))
             (elpy-test test-whole-project)))
         (eval-after-load 'elpy
           '(progn
              (define-key elpy-mode-map
                (kbd "C-c t") 'elpy-test-pdb)))))

;(setq elpy-test-pytest-runner-command '("py.test" "--pdb" "--capture=no"))
;(setq elpy-test-pytest-runner-command '("py.test" "--pdb" "--disable-warnings"))
;(setq elpy-test-compilation-function 'pdb)




;; Use IPython for REPL
;(setq python-shell-interpreter "jupyter"
;      python-shell-interpreter-args "console --simple-prompt"
;      python-shell-prompt-detect-failure-warning nil)
;(add-to-list 'python-shell-completion-native-disabled-interpreters
;             "jupyter")

;; Enable Flycheck
(when (require 'flycheck nil t)
  (setq elpy-modules (delq 'elpy-module-flymake elpy-modules))
  (add-hook 'elpy-mode-hook 'flycheck-mode))


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
(setq org-format-latex-options (plist-put org-format-latex-options :scale 2.00))


(defun my-flymd-browser-function (url)
  (let ((browse-url-browser-function 'browse-url-firefox))
    (browse-url url)))
(setq flymd-browser-open-function 'my-flymd-browser-function)
