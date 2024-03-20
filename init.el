(setq custom-file "~/.emacs-custom.el")
(load custom-file 'noerror)

(set-frame-font "CaskaydiaCove Nerd Font 12" nil t)

(menu-bar-mode -1)
(tool-bar-mode -1)

(windmove-default-keybindings)

(setq-default whitespace-style '(empty
                                 face
                                 indentation
                                 trailing
                                 tabs
                                 tab-mark
                                 spaces
                                 space-mark))
(setq-default whitespace-line-column 80)
(global-whitespace-mode 1)

(global-display-line-numbers-mode)
(setq-default indent-tabs-mode nil)

(electric-indent-mode -1)

(require 'package)
(add-to-list 'package-archives
             '("melpa-stable" . "https://melpa.org/packages/")
             t)

(eval-when-compile (require 'use-package))
(setq use-package-always-ensure t)

(use-package emacs)

(use-package project
  :init
  (setq project-vc-merge-submodules nil))

(use-package exec-path-from-shell
  :config
  (when (memq window-system '(mac ns x pgtk))
    (exec-path-from-shell-initialize)))

(use-package vertico
  :config
  (vertico-mode))

(use-package marginalia
  :config
  (marginalia-mode))

(use-package orderless
  :init
  (setq completion-styles '(orderless basic)
        completion-category-defaults nil
        completion-category-overrides '((file (styles partial-completion)))))

(use-package embark
  :bind
  (("C-." . embark-act)
   ("C-," . embark-dwim))
  :init
  (setq prefix-help-command #'embark-prefix-help-command))

(use-package consult
  :bind
  (("M-s r" . consult-ripgrep)))

(use-package embark-consult
  :hook
  ((embark-collect-mode . consult-preview-at-point-mode)
  ;; Enable automatic preview at point in the *Completions* buffer. This is
  ;; relevant when you use the default completion UI.
   (completion-list-mode . consult-preview-at-point-mode)))

(use-package magit
  :init
  (setq transient-default-level 5))

(use-package doom-modeline :config (doom-modeline-mode))
(use-package doom-themes
  :config
  (load-theme 'doom-one-light t)
  (doom-themes-visual-bell-config)
  (doom-themes-org-config))

(use-package cape)
(use-package yasnippet-capf
  :after cape
  :config
  (add-to-list 'completion-at-point-functions #'yasnippet-capf))

(use-package corfu
  :init
  (setq corfu-auto t
        corfu-auto-delay 0.1
        corfu-auto-prefix 1)
  (global-corfu-mode))

(use-package rustic
  :config
  (setq rustic-format-trigger 'on-save
        rustic-rustfmt-args "+nightly"))

(use-package flymake
  :config
  (define-key flymake-mode-map (kbd "M-n") 'flymake-goto-next-error)
  (define-key flymake-mode-map (kbd "M-p") 'flymake-goto-prev-error))

(use-package lsp-mode
  :init
  (defun corfu-lsp-setup ()
    (setq-local completion-styles '(orderless)
                completion-category-defaults nil))
  (add-hook 'lsp-mode-hook #'corfu-lsp-setup)

  (setq lsp-keymap-prefix "C-c l"
        lsp-inlay-hint-enable t
        lsp-completion-provider :none
        lsp-signature-auto-activate nil)
  :hook
  ((rust-mode . lsp)))

(use-package yasnippet
  :config
  (yas-global-mode 1)
  (define-key yas-minor-mode-map (kbd "<tab>") nil)
  (define-key yas-minor-mode-map (kbd "TAB") nil)
  (define-key yas-minor-mode-map (kbd "C-c y") #'yas-expand))
(use-package yasnippet-snippets)
