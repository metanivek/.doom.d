;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; DOOM
(defun doom-dashboard-draw-ascii-banner-fn ()
  (let* ((banner
          '(
            "  .-''-.                      .--.  .-. .--------.                      .-''-."
            " /      `'''--..              ||  \\/  ||'=====. ||              ..--'''`      \\"
            "|               '.            || .  . ||  .---' ||            .'               |"
            "|           ..''` '---.       || |\\/|_||  '===. ||       .---' `''..           |"
            "|        .``           ''''\\  ||_|\\/|.'       |_||  /''''           ``.        |"
            "/'..   /`              /    /'|_.'            '._|'\\    \\              `\\   ..'\\"
            "|   `:'         ___..  \\   /  /                  \\  \\   /  ..___         ':`   | "
            "'____'__...---'':::::\\  '-' ./                    \\. '-'  \\:::::''---...__'____' "
            "  \\::/\\ \\:::::::::::':  ___/                        \\___  :':::::::::::/ /\\::/"
            "   \\'| \\ '-:::--'`  .' /              REST              \\ '.  `'--:::-' / |'/"
            "   /'|  \\    ....''`__/                IN                \\__`''....    /  |'\\"
            "   \\ |   .   |  .-'`   .------. .------..------. .-. .--.   `'-.  |   .   | /"
            "    \\/::.'   |  |      ||  _   V   _   ||   _   V  \\/  ||      |  |   '.::\\/"
            "    \\':'_.---|  |      || | |  |  | |  ||  | |  | .  . ||      |  |---._':'/"
            "     \\\\      |  |      || | |  |   '|  ||  |'   | |\\/| ||      |  |      //"
            "     \\\\      |  |      || |' .'|'.   .'||'.   .'|'|\\/| ||      |  |      //"
            "      \\\\      | |      ||  .'.' '.'.'.'  '.'.'.' '|  | ||      | |      //"
            "      \\\\      | |      ||.'.'     '.'      '.'       |.||      | |      //"
            "       \\\\     |'       |_.'                          '._|       '|     //"
            ""
            ))
         (longest-line (apply #'max (mapcar #'length banner))))
    (put-text-property
     (point)
     (dolist (line banner (point))
       (insert (+doom-dashboard--center
                +doom-dashboard--width
                (concat
                 line (make-string (max 0 (- longest-line (length line)))
                                   32)))
               "\n"))
     'face 'doom-dashboard-banner)))

;;; Typography
;; (setq doom-font (font-spec :family "Liberation Mono" :size 32))
(setq doom-font (font-spec :family "FiraCode Nerd Font" :size 32))
(setq doom-big-font-increment 6)
(setq emojify-emoji-set "twemoji-v2")

;;; Theme
;; dark
;; (setq my-theme 'doom-vibrant)
;; (setq my-theme 'doom-nord)
;; (setq my-theme 'doom-palenight)
;; (setq my-theme 'doom-snazzy)
;; (setq my-theme 'doom-acario-dark)
;; (setq my-theme 'doom-outrun-electric)
;; (setq my-theme 'doom-gruvbox)
;; (setq my-theme 'doom-solarized-dark)
;; (setq my-theme 'doom-solarized-dark-high-contrast)
;; (setq my-theme 'doom-monokai-spectrum)
;; (setq my-theme 'doom-challenger-deep)
;; (setq my-theme 'doom-molokai)
;; (setq my-theme 'doom-xcode)
;; (setq my-theme 'doom-spacegrey)
(setq my-theme 'doom-one)

;; light
;; (setq my-theme 'doom-opera-light)
;; (setq my-theme 'doom-one-light)
;; (setq my-theme 'doom-flatwhite)
;; (setq my-theme 'doom-solarized-light)
;; (setq my-theme 'doom-gruvbox-light)
;; (setq my-theme 'doom-tomorrow-day)
;; (setq my-theme 'doom-nord-light)
;; (setq my-theme 'doom-acario-light)

(setq doom-theme my-theme)

;; org face customization
(custom-theme-set-faces! my-theme
  `(outline-1    :foreground ,(doom-color 'violet)       :bold t)
  `(outline-2    :foreground ,(doom-color 'blue)         :bold t)
  `(outline-3    :foreground ,(doom-color 'teal)         :bold t)
  `(outline-4    :foreground ,(doom-lighten 'red 0.2)    :bold t)
  `(outline-5    :foreground ,(doom-color 'gray)         :bold t)
  `(outline-6    :foreground ,(doom-lighten 'orange 0.4) :bold t)
  `(outline-7    :foreground ,(doom-color 'gray)         :bold t)
  `(outline-8    :foreground ,(doom-lighten 'orange 0.4) :bold t)
  `(org-ellipsis :foreground ,(doom-color 'fg)           :bold nil)
  )
;; doom dashboard face customization
(custom-set-faces!
  `(doom-dashboard-banner :foreground ,(doom-color 'red) :bold t)
  `(doom-dashboard-menu-title :foreground ,(doom-color 'gray))
  `(doom-dashboard-menu-desc :foreground ,(doom-color 'gray))
  )

;; solaire-mode adds some nice dimming effects to the interface
;; you can see it particularly with treemacs
(solaire-global-mode +1)

;;; Org Mode
;;;
(setq
 org-directory (expand-file-name "~/org/") ; main directory for all my org files
 org-roam-v2-ack t
 org-roam-directory org-directory
 deft-directory org-directory

 my-main-bib (expand-file-name "~/Nextcloud/bibliography/main.bib") ; main bibilography

 ;; helm-bibtex config
 ;; used for searching for bibliography entries
 bibtex-completion-notes-path org-directory      ; use one file per references
 bibtex-completion-bibliography my-main-bib      ; where to find main bib file
 bibtex-completion-pdf-field "file"              ; the key in entry that points to file location
 )

;; setup org-ref for citations in org
(use-package! org-ref
  :init
  (map! :after org
        :map org-mode-map
        :niv "C-n" #'org-ref-open-notes-at-point)
  :config
  (setq
   org-ref-default-bibliography my-main-bib
   org-ref-notes-directory org-directory
   org-ref-completion-library 'org-ref-ivy-cite
   org-ref-get-pdf-filename-function 'org-ref-get-pdf-filename-helm-bibtex
   ;; REVIEW I /think/ that orb will do this swizzling for us
   org-ref-notes-function 'orb-edit-notes
   ))

;; connect everything to org-roam
;; fyi, orb = org-roam-bibtex
(use-package! org-roam-bibtex
  :after org-roam
  :init
  (map! :after org-roam
        :map org-mode-map
        :niv "C-c n a" #'orb-note-actions)
  :config
  (setq
   orb-preformat-keywords
   '("=key=" "title" "url" "file" "author-or-editor" "keywords")
   ;; this is the main template for creating new note files
   orb-templates
   '(("r" "ref" plain (function org-roam-capture--get-point)
      ""
      :file-name "${slug}"
      :head "#+TITLE: ${=key=}: ${title}
#+ROAM_KEY: ${ref}
#+roam_alias: \"${title}\"
#+roam_tags: ref

+ tags ::
+ keywords :: ${keywords}

* TODO Summary

* Notes\n:PROPERTIES:\n:Custom_ID: ${=key=}\n:URL: ${url}\n:AUTHOR: ${author-or-editor}\n:NOTER_DOCUMENT: %(orb-process-file-field \"${=key=}\")\n:NOTER_PAGE: \n:END:\n\n"
      :unnarrowed t))
   ))

;; org-noter to connect pdfs and notes
(use-package! org-noter
  :after (:any org pdf-view)
  :config
  (setq
   org-noter-always-create-frame t
   org-noter-auto-save-last-location t
   org-noter-separate-notes-from-heading t
   org-noter-default-heading-title "Page $p$"
   org-noter-notes-search-path `(,org-directory)
   )
  )

;; improve latex creation for retina displays by using SVG
(setq org-preview-latex-default-process 'dvisvgm)
;; by default do not export section numbers
(setq org-export-with-section-numbers nil)
;; less indentation to have more horizontal space
(setq org-indent-indentation-per-level 1)
;; adapt indentation, I find this more natural when adding headings
(setq org-adapt-indentation t)
;; keep blank line with cycling visibility
(setq org-cycle-separator-lines 1)
(setq org-startup-folded nil)

;; (use-package! org-roam-server
;;  :ensure t
;;  :config
;;  (setq org-roam-server-host "127.0.0.1"
;;        org-roam-server-port 8181
;;        org-roam-server-authenticate nil
;;        org-roam-server-export-inline-images t
;;        org-roam-server-serve-files nil
;;        org-roam-server-served-file-extensions '("pdf" "mp4" "ogv")
;;        org-roam-server-network-poll t
;;        org-roam-server-network-arrows nil
;;        org-roam-server-network-label-truncate t
;;        org-roam-server-network-label-truncate-length 60
;;        org-roam-server-network-label-wrap-length 20))

(after! org-roam
  (setq
   ;; I find automatically opening the org-roam buffer annoying. disable.
   +org-roam-open-buffer-on-find-file nil
   ;; make backlinks buffer a little more narrow
   org-roam-buffer-width 0.25
   org-roam-index-file "_index.org"
   )
  )
;; set org-agenda to look at org-roam files too
(setq org-agenda-files `(,org-directory))
;; configure how org reports stuck projects
(setq org-stuck-projects '("+LEVEL=2+PROJECT-MAYBE/!-DONE-WAITING-HOLD-CANCELLED" ("NEXT") nil ""))
;; hide scheduled todos from ALL view
(setq org-agenda-todo-ignore-with-date t)
;; only show top-level todos (makes todo list more focused)
(setq org-agenda-todo-list-sublevels nil)
;; add a CLOSED timestamp property when completing todos
(setq org-log-done 'time)

;; configure custom faces
(add-hook! 'doom-load-theme-hook
  (custom-declare-face '+my-todo-active `((t (
                                              :inherit (bold org-todo)
                                              :foreground ,(doom-color 'base8))
                                             )) "")
  (custom-declare-face '+my-todo-next `((t (
                                            :inherit (bold org-todo)
                                            :foreground ,(doom-color 'orange)
                                            )
                                           )) "")
  (custom-declare-face '+my-todo-started `((t (
                                               :inherit (bold org-todo)
                                               :foreground ,(doom-color 'violet)
                                               )
                                              )) "")
  (custom-declare-face '+my-todo-onhold `((t (
                                              :inherit (bold org-todo)
                                              :foreground ,(doom-color 'base4)
                                              )
                                             )) "")
  (custom-declare-face '+my-todo-done '((t (
                                            :inherit (bold success org-todo)
                                            )
                                           )) "")
  (custom-declare-face '+my-todo-xdone `((t (
                                             :inherit (bold org-todo)
                                             :foreground ,(doom-color 'teal)
                                             )
                                            )) "")
  )

(after! org
  ;; enable habits
  (add-to-list 'org-modules 'org-habit)
  ;; setup org roam capture templates
  (setq org-roam-capture-templates
        '(
          ("n" "note" plain (function org-roam--capture-get-point)
           "%?"
           :file-name "%<%Y%m%d%H%M%S>-${slug}"
           :head "#+TITLE: ${title}\n"
           :unnarrowed t)
          ("p" "permanent" plain (function org-roam--capture-get-point)
           "+ tags :: %?\n\n* Note\n"
           :file-name "p_%<%Y%m%d%H%M%S>"
           :head "#+TITLE: ${title}\n#+roam_tags: perm\n\n"
           :unnarrowed nil)
          )
        )
  (setq org-roam-capture-ref-templates
        '(("w" "website" plain (function org-roam--capture-get-point)
           "+ source :: ${ref}\n+ tags :: %?\n+ description :: ${body}\n\n* TODO read\n\n* Summary\n\n* Notes"
           :file-name "w_%<%Y%m%d%H%M%S>-${slug}"
           :head "#+TITLE: ${title}\n#+roam_key: ${ref}\n#+roam_tags: ref\n\n"
           :unnarrowed t)
          )
        )
  (setq org-capture-templates
        '(
          ("t" "Todo" entry
           (file+headline "_todo.org" "Inbox")
           "* TODO %?\n%i\nfile:%F\n%U" :prepend t)
          ("c" "Correspondence" entry
           (file+headline "_todo.org" "Correspondence")
           "* TODO %?\n%i\n%U" :prepend t)
          ("e" "Email" entry
           (file+headline "_todo.org" "Correspondence")
           "* TODO [#A] %?\nSCHEDULED: %(org-insert-time-stamp (org-read-date nil t \"+0d\"))\n%a\n")
          ("f" "Fleeting" entry
           (file+headline "_xfleeting.org" "Inbox")
           "* %U\n%?\n%i\nfile:%F" :prepend nil)
          ("g" "Gratitude" entry
           (file+olp+datetree "_gratitude.org")
           "* %?")
          ;; Link captures are for quickly storing links from my browser
          ("l" "Link" entry
           (file+olp+datetree "_links.org")
           "* %:annotation\n\"%:initial\"\n%?" :empty-lines 1)
          ;; see the doom org config.el for more capture template ideas
          ))
  ;; configure TODO states
  ;; based on http://doc.norang.ca/org-mode.html
  (setq org-todo-keywords
        '((sequence "TODO(t)" "NEXT(n)" "STARTED(s)" "|" "DONE(d)")
          (sequence "WAITING(w@/!)" "HOLD(h@/!)" "|" "CANCELLED(c@/!)" "PHONE" "MEETING")))
  (setq org-todo-keyword-faces
        '(("TODO"      . +my-todo-active)
          ("NEXT"      . +my-todo-next)
          ("STARTED"   . +my-todo-started)
          ("DONE"      . +my-todo-done)
          ("WAITING"   . +my-todo-onhold)
          ("HOLD"      . +my-todo-onhold)
          ("CANCELLED" . +my-todo-xdone)
          ("PHONE"     . +my-todo-xdone) ; REVIEW I might not end up using this one much
          ("MEETING"   . +my-todo-xdone)))
  (setq org-todo-state-tags-triggers
        '(("CANCELLED" ("CANCELLED" . t))
          ("WAITING" ("WAITING" . t))
          ("HOLD" ("WAITING") ("HOLD" . t))
          (done ("WAITING") ("HOLD"))
          ("TODO" ("WAITING") ("CANCELLED") ("HOLD"))
          ("STARTED" ("WAITING") ("CANCELLED") ("HOLD"))
          ("NEXT" ("WAITING") ("CANCELLED") ("HOLD"))
          ("DONE" ("WAITING") ("CANCELLED") ("HOLD"))))
  (setq org-agenda-start-day "0d"
        org-agenda-span 3)
  (setq org-agenda-tags-column 80)
  (setq org-habit-preceding-days 7
        org-habit-following-days 3
        org-habit-graph-column 80
        org-habit-show-done-always-green t
        org-habit-show-habits-only-for-today t
        org-habit-show-all-today t)
  ;; I don't like the auto-resizing thing doom does
  (remove-hook 'org-agenda-mode-hook #'+org-habit-resize-graph-h)
  ;; explicitly load org modules
  (org-load-modules-maybe t)
  )

;; customized agenda view
;; inspired by https://blog.aaronbieber.com/2016/09/24/an-agenda-for-life-with-org-mode.html
(defun air-org-skip-subtree-if-priority (priority)
  "Skip an agenda subtree if it has a priority of PRIORITY.

PRIORITY may be one of the characters ?A, ?B, or ?C."
  (let ((subtree-end (save-excursion (org-end-of-subtree t)))
        (pri-value (* 1000 (- org-lowest-priority priority)))
        (pri-current (org-get-priority (thing-at-point 'line t))))
    (if (= pri-value pri-current)
        subtree-end
      nil)))
(setq org-agenda-custom-commands
      '(("k" "Kustom Agenda"
         ((tags "PRIORITY=\"A\""
                ((org-agenda-skip-function '(org-agenda-skip-entry-if 'todo 'done))
                 (org-agenda-overriding-header "Unfinished tasks:")))
          (agenda "")
          (stuck ""
                 ((org-agenda-overriding-header "Stuck projects:")))
          (alltodo ""
                   ((org-agenda-skip-function '(or (org-agenda-skip-entry-if 'regexp ":PROJECT:")
                                                   (air-org-skip-subtree-if-priority ?A)))
                    (org-agenda-overriding-header "Unscheduled tasks:")
                    (org-agenda-sorting-strategy '((todo
                                                    user-defined-down
                                                    priority-down
                                                    category-keep))))))
         ((org-agenda-block-separator "~~~~")))))

;; custom sorting based on todo state
;; I want NEXT and WAITING to appear at the top of agenda sorting
(defun kls-compare-todo-state (a b)
  (let (
        (tsa (org-entry-get (get-text-property 0 'org-hd-marker a) "TODO"))
        (tsb (org-entry-get (get-text-property 0 'org-hd-marker b) "TODO"))
        (order (list "NEXT" "WAITING" "TODO"))
        )
    (if (< (seq-position order tsa) (seq-position order tsb))
        +1 -1)))
(setq org-agenda-cmp-user-defined #'kls-compare-todo-state)


;; tweak autocomplete with comapny so that it appears quickly
(after! company
  (setq company-idle-delay 0
        company-minimum-prefix-length 2
        company-show-quick-access t
        company-tooltip-minimum-width 30
        company-tooltip-maximum-width 60))

;; projectile setup
(setq projectile-project-search-path
      '("~/oss-code/" "~/code/" "~/paid-projects/"))
(setq org-projectile-projects-file
      (expand-file-name "project-todos.org" org-directory))
(use-package! org-projectile
  :after org
  :config
  (push (org-projectile-project-todo-entry) org-capture-templates)
  )

;; switch to new window after a split
(setq evil-split-window-below t
      evil-vsplit-window-right t)

;; treemacs config
(setq +treemacs-git-mode nil      ; I don't need git in my treemacs
      treemacs-position 'left     ; pos
      treemacs-silent-filewatch t ; shh
      treemacs-silent-refresh t   ; shh
      treemacs-resize-icons 36)   ; hidpi goodness

;; tweak some defaults
(setq-default
 ;; REVIEW turn off resizing behavior bc I think it might be causing issues
 ;; with SPC w o
 window-combination-resize t ; take space from all windows when splitting
 x-stretch-cursor t          ; take up entire space of glyph
 evil-shift-width 2
 tab-width 2
 )

;;; General Config
(setq
 auto-save-default t                 ; auto save!
 truncate-string-ellipsis "…"        ; lets use the real ellipsis character, looks nicer
 global-auto-revert-mode t           ; update buffers if files change outside emacs
 display-line-numbers-type t
 )

;; auto break lines of text when writing
(add-hook 'text-mode-hook 'auto-fill-mode)
;; what does this do?
(setq display-fill-column-indicator t)

;; convenience functions to undo fill mode
(defun unfill-paragraph ()
  (interactive)
  (let ((fill-column (point-max)))
    (fill-paragraph nil)))
(defun unfill-region ()
  (interactive)
  (let ((fill-column (point-max)))
    (fill-region (region-beginning) (region-end) nil)))

;; convenience for getting text out of emacs to other places that aren't fill-friendly
(defun unfill-copy-refill ()
  (interactive)
  (unfill-region)
  (evil-yank (region-beginning) (region-end))
  (fill-region (region-beginning) (region-end) nil))

;; abbrev
(set-default 'abbrev-mode t)
(setq save-abbrevs nil)
(setq abbrev-file-name "~/.doom.d/abbrev_defs.el")

;;
;; keymappings
;;
;; maintain comment behavior with meta, since we remapped command keeping
(map! :nie "M-/" #'comment-dwim)
;; similar but for pasting (old habits die hard)
(map! :g "M-v" #'yank)
;; olivetti toggle
(map! :g "s-o" #'olivetti-mode)
;; modeline toggle
(map! :g "s-m" #'doom-modeline-mode)
;; quick access to calculator
(map! :g "s-c" #'calc)

;; weird override but change to correspond to line
;; motion of j/k and where I have { and }
;; thanks, planck
(map! :m "{" #'evil-forward-paragraph)
(map! :m "}" #'evil-backward-paragraph)

(map! :map tidal-mode-map :g "C-'" 'tidal-run-multiple-lines)

;; don't show utf-8 in modeline since most files *ought* to be this already
(defun doom-modeline-conditional-buffer-encoding ()
  (setq-local doom-modeline-buffer-encoding
              (unless (or (eq buffer-file-coding-system 'utf-8-unix)
                          (eq buffer-file-coding-system 'utf-8)))))
(add-hook 'after-change-major-mode-hook #'doom-modeline-conditional-buffer-encoding)


;; lets make which key show up quickly!
(setq which-key-idle-delay 0.5)

;; let avy search across all windows
(setq avy-all-windows t)

;; center text when visual wrapping is on
(setq visual-fill-column-center-text t)

(setq ispell-dictionary "en")

;; macros
(fset 'li
      (kmacro-lambda-form [?j ?^ ?i ?< ?l ?i escape ?$ ?a ?< ?/ escape] 0 "%d"))


;;
;; LSP
;;

(setq
  lsp-modeline-code-actions-enable nil
  lsp-lens-enable nil
  lsp-headerline-breadcrumb-enable t
  lsp-headerline-breadcrumb-segments '(file symbols)
  )


;;
;; package configs
;;

(setq tidal-boot-script-path "~/.cabal/store/ghc-8.10.4/tidal-1.7.7-fc542b3085c2f32ca34caec6b01fca885187ba065658677ecd7c111008302771/share/BootTidal.hs")

(setq cider-lein-command "lein-art")

;; michelson
(load "~/code/tezos/emacs/michelson-mode.el" nil t)
(setq michelson-client-command "~/code/tezos/tezos-client")
(setq michelson-alphanet nil)


;; simpler minimal writing environment
(use-package! olivetti
  :config
  (setq-default olivetti-body-width 110)
  :defer-incrementally t)


;; configure prettier
;; (defun enable-minor-mode (my-pair)
;;   "Enable minor mode if filename match the regexp.  MY-PAIR is a cons cell (regexp . minor-mode)."
;;   (if (buffer-file-name)
;;       (if (string-match (car my-pair) buffer-file-name)
;;           (funcall (cdr my-pair)))))

(use-package! prettier-js)
;; only enable for JSX in web mode
;; (add-hook! 'web-mode-hook #'(lambda ()
;;                               (enable-minor-mode
;;                                '("\\.jsx?\\'" . prettier-js-mode)))
;;            )
(add-hook! 'js2-mode-hook 'prettier-js-mode)
(add-hook! 'web-mode-hook 'prettier-js-mode)

;; turn off formatting for markdown
(add-to-list '+format-on-save-enabled-modes 'markdown-mode t)

;; try RLS
(after! rustic
  (setq rustic-lsp-server 'rls))

;; O Camel
(add-hook 'tuareg-mode-hook #'(lambda() (setq mode-name "🐫")))

(setq merlin-error-after-save t)

;; (setq-hook! 'tuareg-mode +format-with 'ocamlformat)

;; (setq format-all-debug 't)

;; (add-hook! 'tuareg-mode-hook 'format-all-ensure-formatter)
;; (add-hook! 'tuareg-mode-hook 'format-all-mode)

;; vlf helps load REALLY large files. it will prompt to use.
(use-package! vlf-setup
  :defer-incrementally vlf-tune vlf-base vlf-write vlf-search vlf-occur vlf-follow vlf-ediff vlf)
