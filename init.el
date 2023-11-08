(set-frame-font "CaskaydiaCove Nerd Font 12" nil t)

(windmove-default-keybindings)

(setq-default whitespace-style '(
  face trailing tabs spaces
  empty indentation
  space-mark
  tab-mark
))
(setq-default whitespace-line-column 80)
(global-whitespace-mode 1)

(setq-default indent-tabs-mode nil)

(electric-indent-mode -1)
(add-hook 'after-change-major-mode-hook (lambda () (electric-indent-mode -1)))

(require 'package)
(add-to-list
  'package-archives
 '("melpa-stable" . "https://melpa.org/packages/")
  t
)
(eval-when-compile (require 'use-package))
(setq use-package-always-ensure t)

(use-package exec-path-from-shell
  :config
  (when (memq window-system '(mac ns x))
    (exec-path-from-shell-initialize)
  )
)

(use-package rg)

(use-package flymake
  :config
  (define-key flymake-mode-map (kbd "M-n") 'flymake-goto-next-error)
  (define-key flymake-mode-map (kbd "M-p") 'flymake-goto-prev-error)
)

(use-package vertico
  :config
  (vertico-mode)
)

(use-package savehist :init (savehist-mode))
(use-package orderless
  :init
  (setq
    completion-styles '(orderless basic)
    completion-category-defaults nil
    completion-category-overrides '((file (styles partial-completion)))
  )
)

(use-package doom-modeline :hook (after-init . doom-modeline-mode))
(use-package doom-themes
  :config
  (load-theme 'doom-one-light t)
  (doom-themes-visual-bell-config)
  (doom-themes-org-config)
)

(use-package which-key
  :init (setq which-key-idle-delay 0.2)
  :hook (after-init . which-key-mode)
)

(use-package vterm)

(use-package projectile
  :config
  (setq projectile-enable-caching t)
  (projectile-mode +1)
  (define-key projectile-mode-map (kbd "C-c p") 'projectile-command-map)
)

(use-package magit)

(use-package company
  :config
  (setq company-minimum-prefix-length 2)
  (company-mode)
)

(use-package rustic
  :config
  (setq
    rustic-format-trigger 'on-save
    rustic-rustfmt-args "+nightly"
  )
)

(use-package lsp-mode
  :init
  (setq lsp-keymap-prefix "C-c l")
  :config
  (setq lsp-inlay-hint-enable t)
  :hook
  ( (rust-mode . lsp-deferred)
    (lsp-mode . lsp-enable-which-key-integration)
  )
  :commands (lsp lsp-deferred)
)
(use-package lsp-ui :commands lsp-ui-mode)

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
   '(rg magit projectile company company-mode lsp-mode rustic which-key vterm use-package doom-themes doom-modeline))
 '(safe-local-variable-values
   '((lsp-file-watch-ignored-directories quote
                                         ("[/\\\\].git\\'" "[/\\\\]afl\\'" "[/\\\\]runtimes\\'" "[/\\\\]target\\'"))
     (eval append 'lsp-file-watch-ignored-directories
           '("[/\\\\]afl\\'" "[/\\\\]runtimes\\'" "[/\\\\]target\\'"))
     (eval append 'lsp-file-watch-ignored-directories
           ("[/\\\\]afl\\'" "[/\\\\]runtimes\\'" "[/\\\\]target\\'"))
     (eval add-to-list 'lsp-file-watch-ignored-directories "[/\\\\]runtimes\\'"))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
