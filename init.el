(set-frame-font "CaskaydiaCove Nerd Font 12" nil t)

(setq-default indent-tabs-mode nil)

(electric-indent-mode -1)
(add-hook 'after-change-major-mode-hook (lambda () (electric-indent-mode -1)))

(eval-when-compile (require 'use-package))

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
