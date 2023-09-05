(defvar elpaca-installer-version 0.5)
(defvar elpaca-directory (expand-file-name "elpaca/" user-emacs-directory))
(defvar elpaca-builds-directory (expand-file-name "builds/" elpaca-directory))
(defvar elpaca-repos-directory (expand-file-name "repos/" elpaca-directory))
(defvar elpaca-order '(elpaca :repo "https://github.com/progfolio/elpaca.git"
                              :ref nil
                              :files (:defaults (:exclude "extensions"))
                              :build (:not elpaca--activate-package)))
(let* ((repo  (expand-file-name "elpaca/" elpaca-repos-directory))
       (build (expand-file-name "elpaca/" elpaca-builds-directory))
       (order (cdr elpaca-order))
       (default-directory repo))
  (add-to-list 'load-path (if (file-exists-p build) build repo))
  (unless (file-exists-p repo)
    (make-directory repo t)
    (when (< emacs-major-version 28) (require 'subr-x))
    (condition-case-unless-debug err
        (if-let ((buffer (pop-to-buffer-same-window "*elpaca-bootstrap*"))
                 ((zerop (call-process "git" nil buffer t "clone"
                                       (plist-get order :repo) repo)))
                 ((zerop (call-process "git" nil buffer t "checkout"
                                       (or (plist-get order :ref) "--"))))
                 (emacs (concat invocation-directory invocation-name))
                 ((zerop (call-process emacs nil buffer nil "-Q" "-L" "." "--batch"
                                       "--eval" "(byte-recompile-directory \".\" 0 'force)")))
                 ((require 'elpaca))
                 ((elpaca-generate-autoloads "elpaca" repo)))
            (progn (message "%s" (buffer-string)) (kill-buffer buffer))
          (error "%s" (with-current-buffer buffer (buffer-string))))
      ((error) (warn "%s" err) (delete-directory repo 'recursive))))
  (unless (require 'elpaca-autoloads nil t)
    (require 'elpaca)
    (elpaca-generate-autoloads "elpaca" repo)
    (load "./elpaca-autoloads")))
(add-hook 'after-init-hook #'elpaca-process-queues)
(elpaca `(,@elpaca-order))


;; Install use-package support
(elpaca elpaca-use-package
  ;; Enable :elpaca use-package keyword.
  (elpaca-use-package-mode)
  ;; Assume :elpaca t unless otherwise specified.
  (setq elpaca-use-package-by-default t))

;; Block until current queue processed.
(elpaca-wait)

;;Turns off elpaca-use-package-mode current declartion
;;Note this will cause the declaration to be interpreted immediately (not deferred).
;;Useful for configuring built-in emacs features.
(use-package emacs :elpaca nil :config (setq ring-bell-function #'ignore))

;; Don't install anything. Defer execution of BODY
;;(elpaca nil (message "deferred"))

(use-package evil
  :init
  (setq evil-want-integration t)
  (setq evil-want-keybinding nil)
  (setq evil-vsplit-window-right t)
  (setq evil-split-window-below t)
  (evil-mode))

(use-package evil-collection
  :after evil
  :config
  (setq evil-collection-mode-list '(dashboard dired ibuffer))
  (evil-collection-init))

(use-package evil-tutor)

(use-package evil-escape
  :init
  (evil-escape-mode)
  (setq-default evil-escape-key-sequence "jk"))

(use-package general
  :config (general-evil-setup)

  ;; setup 'SPC' as leader key
  (general-create-definer 6pak/leader-keys
    :states '(normal insert visual emacs)
    :keymaps 'override
    :prefix "SPC"
    :global-prefix "C-SPC")  ;to access leader in insert mode

  (6pak/leader-keys         ;;; Top level keybinds
    "/"  '(comment-line     :wk "Comment Line")
    "s"  '(save-buffer      :wk "Save File"))

  (6pak/leader-keys         ;;; Buffer Keybinds 
    "b"  '(:ignore t        :wk "Buffer")
    "bb" '(switch-to-buffer :wk "Switch Buffer")
    "bk" '(kill-this-buffer :wk "Kill Buffer")
    "bi" '(ibuffer          :wk "IBuffer")
    "bn" '(next-buffer      :wk "Next Buffer")
    "bp" '(previous-buffer  :wk "Previous Buffer")
    "br" '(revert-buffer    :wk "Reload Buffer"))

  (6pak/leader-keys         ;;; Evaluate E-lisp Keybinds
    "e"  '(:ignore t        :wk "Evaluate E-Lisp")
    "eb" '(eval-buffer      :wk "Evaluate Buffer")
    "ed" '(eval-defun       :wk "Evaluate defun")
    "ee" '(eval-expression  :wk "Evaluate Expression")
    "er" '(eval-region      :wk "Evaluate Region"))

  (6pak/leader-keys         ;;; File Keybinds
    "f"  '(:ignore t        :wk "File")
    "ff" '(find-file        :wk "Find File")
    "fc" '((lambda () (interactive) (find-file "~/.config/emacs/config.org")) :wk "Edit Config"))

  (6pak/leader-keys         ;;; Help Keybinds
    "h"  '(:ignore t        :wk "Help")
    "hh" '(describe-symbol  :wk "Describe Symbol")) 
)

(set-face-attribute 'default nil
                    :font "IntelOne Mono"
                    :height 110
                    :weight 'medium)
(set-face-attribute 'variable-pitch nil
                    :font "Ubuntu Nerd Font"
                    :height 120
                    :weight 'medium)
(set-face-attribute 'fixed-pitch nil
                    :font "IntelOne Mono"
                    :height 110
                    :weight 'medium)

(menu-bar-mode   -1)
(tool-bar-mode   -1)
(scroll-bar-mode -1)

(setq inhibit-startup-message t)

(global-display-line-numbers-mode 1)
(setq display-line-numbers 'relative)

(use-package which-key
  :init
  (which-key-mode 1)
  :config
  (setq which-key-side-window-location         'bottom
        which-key-sort-under                   #'which-key-key-order-alpha
        which-key-sort-uppercase-first         nil
        which-key-add-column-padding           1
        which-key-max-display-columns          nil
        which-key-min-display-lines            6
        which-key-side-window-slot             -10
        which-key-side-window-max-height       0.25
        which-key-idle-delay                   0.5
        which-key-max-description-length       25
        which-key-allow-imprecise-window-fit   t
        which-key-seperator                    " → "))

; (use-package night-owl)
 ; (load-theme 'night-owl t)
(use-package nordic-night-theme
  :ensure t
  :config
  (load-theme 'nordic-night t))

(use-package toc-org
  :commands toc-org-enable
  :init (add-hook 'org-mode-hook 'toc-org-enable))

(add-hook 'org-mode-hook 'org-indent-mode)
(use-package org-bullets)
(add-hook 'org-mode-hook (lambda () (org-bullets-mode 1)))

(electric-indent-mode -1)
