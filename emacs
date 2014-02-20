(custom-set-variables
  ;; custom-set-variables was added by Custom.
  ;; If you edit it by hand, you could mess it up, so be careful.
  ;; Your init file should contain only one such instance.
  ;; If there is more than one, they won't work right.
 '(TeX-modes (quote (latex-mode)))
 '(inhibit-startup-screen t)
 '(load-home-init-file t t))

(require 'color-theme)
(color-theme-initialize)
(color-theme-subtle-hacker)

(global-font-lock-mode t)
(setq font-lock-maximum-decoration t)

(require 'tramp)
(setq tramp-default-method "scpc")

(add-hook 'python-mode-hook
          '(lambda () (define-key python-mode-map "\C-m" 'newline-and-indent)))
(add-hook 'python-mode-hook 'whitespace-mode)

(setq whitespace-line-column 100)
(setq whitespace-style
      '(tabs newline tab-mark newline-mark lines trailing))
(global-set-key (kbd "<f8>") 'whitespace-cleanup)

(add-hook 'text-mode-hook  'turn-on-auto-fill)
(add-hook 'latex-mode-hook  'turn-on-auto-fill)

(autoload 'flyspell-mode "flyspell" "On-the-fly spelling checker." t)

(defun wc (&optional begin end)
  "count words between BEGIN and END (region); if no region defined, count words in buffer"
  (interactive "r")
  (let ((b (if mark-active begin (point-min)))
      (e (if mark-active end (point-max))))
    (message "Word count: %s" (how-many "\\w+" b e))))

(global-set-key "\C-l" 'goto-line)


;; allow for export=>beamer by placing
;; #+LaTeX_CLASS: beamer in org files
(unless (boundp 'org-export-latex-classes)
  (setq org-export-latex-classes nil))
(add-to-list 'org-export-latex-classes
  ;; beamer class, for presentations
  '("beamer"
     "\\documentclass[11pt]{beamer}\n"

     ("\\section{%s}" . "\\section*{%s}")

     ("\\begin{frame}[fragile]\\frametitle{%s}"
       "\\end{frame}"
       "\\begin{frame}[fragile]\\frametitle{%s}"
       "\\end{frame}")))
(add-to-list 'org-export-latex-classes
             '("article"
               "\\documentclass{article}"
               ("\\section{%s}" . "\\section*{%s}")))

(global-set-key [f12] 'recompile)

(set-default-font "Monospace-10")

(scroll-bar-mode -1)
(menu-bar-mode 0)
(tool-bar-mode 0)

