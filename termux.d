#+title  My Emacs Configuration
* Emacs Settings
** Default coding system
   #+begin_src emacs-lisp
     (set-default-coding-systems 'utf-8)
   #+end_src
** Usability
#+begin_src emacs-lisp
  (global-set-key (kbd "<escape>") 'keyboard-escape-quit) ;; ESC as quit key
  (setq create-lockfiles nil) ;; Don't create lock files
  (winner-mode 1) ;; Winner  mode, undo window  configuration  changes
  (electric-pair-mode 1) ;; Global electric  pair  mode
#+end_src
** Autosave Directory
#+begin_src emacs-lisp
  (setq auto-save-file-name-transforms
	    `((".*" ,(concat user-emacs-directory "auto-save/") t))) 
#+end_src
** UI
 #+begin_src emacs-lisp
   (global-hl-line-mode 1) ;; Highlights current line
   (global-visual-line-mode) ;; Visual Line Everywhere
   (blink-cursor-mode 1) ;; Enable Blinking Cursor
   (column-number-mode) ;; Display Column Number in StatusBar
   (global-display-line-numbers-mode 1) ;; Display linenumbers globaly
   (dolist (mode '(org-mode-hook   ;; Disable line numbers for some modes
		   term-mode-hook
		   shell-mode-hook
		   treemacs-mode-hook
		   eshell-mode-hook))
     (add-hook mode (lambda () (display-line-numbers-mode 0)
		      )
	       )
     )
 #+end_src
** Fonts
   #+begin_src emacs-lisp
     (set-face-attribute 'default nil :font "Open Sans" :height 140)
     ;; Set the fixed pitch face
     (set-face-attribute 'fixed-pitch nil :font "JetBrainsMono" :height 140)
     ;; Set the variable pitch face
     (set-face-attribute 'variable-pitch nil :font "Open Sans Light" :height 140  :weight 'regular)
   #+end_src
** Rainbow Delimiters - Color maching parenthesis
#+begin_src emacs-lisp
  (use-package rainbow-delimiters
    :hook (prog-mode . rainbow-delimiters-mode) ;;prog-mode is a default programing mode for all languages
    )
#+end_src
** Disable Menus and tooltips
   #+begin_src emacs-lisp
     (menu-bar-mode -1) ;; Disable the menu bar
     (toggle-scroll-bar -1) ;; Disable the scrollbar
     (tool-bar-mode -1) ;; Disable the tool bar
     (tooltip-mode -1) ;; Disable tooltips
   #+end_src
** Theme
 #+begin_src emacs-lisp
   (load-theme 'deeper-blue)
 #+end_src
* General 
#+begin_src emacs-lisp
    (use-package general
      :after which-key
      :config
      (general-override-mode 1)
  
      (general-create-definer tyrant-def
	:states '(normal visual insert m
			 otion emacs)
	:prefix "SPC"
	:non-normal-prefix "C-SPC")
  
      (general-define-key
       :keymaps 'key-translation-map
       "ESC" (kbd "C-g"))
  
      (general-def
	;; copy paste
	"S-C-x" 'kill-region
	"S-C-c" 'kill-ring-save
	"S-C-v" 'yank
	;; Window navigation
	"S-C-h"  'windmove-left
	"S-C-j"  'windmove-down
	"S-C-k"  'windmove-up
	"S-C-l"  'windmove-right
	"S-C-i"  'completion-at-point
	)
  
      (tyrant-def
	""  nil
	"'" (general-simulate-key "C-c '")
	"," (general-simulate-key "C-c C-,")
	"c" (general-simulate-key "C-c C-c")
	"k" (general-simulate-key "C-c C-k")
	"h"  (general-simulate-key "C-h")
	"u"  (general-simulate-key "C-u")
	"x"  (general-simulate-key "C-x")
	"e"  (general-simulate-key "C-x C-e")
	"t"  (general-simulate-key "C-c C-t")
	;; Quit operations
	"q"  '(:ignore t :which-key "quit emacs")
	"qq"  'kill-emacs
	"qz"  'delete-frame
	;; Buffer operations
	"b"  '(:ignore t :which-key "buffer")
	"bb"  'ivy-switch-buffer
	"bo"  'mode-line-other-buffer
	"bd"  'kill-this-buffer
	"bj"  'next-buffer
	"bk"  'previous-buffer
	"bq"  'kill-buffer-and-window
	"bR"  'revert-buffer
	"br"  'rename-file-and-buffer
	"be"  'eval-buffer
	;; Window operations
	"w"  '(:ignore t :which-key "window")
	"wh"  'windmove-left
	"wj"  'windmove-down
	"wk"  'windmove-up
	"wl"  'windmove-right
	"wm"  'maximize-window
	"wb"  'split-window-horizontally
	"wv"  'split-window-vertically
	"wm"  'maximize-window
	"wu"  'winner-undo
	"wo"  'other-window
	"wd"  'delete-window
	"wD"  'delete-other-windows
	;; File operations
	"f"  '(:ignore t :which-key "files")
	"fc"  'write-file
	"fj"  'dired-jump
	"fl"  'find-file-literally
	"fr"  'rename-file-and-buffer
	"fR"  'recover-this-file
	"s"   'save-buffer
	;; Applications
	"a"  '(:ignore t :which-key "Applications")
	"ad" 'dired
	"ac" 'calendar
	"ag"  'magit
	"g"  'magit
	":"  'shell-command
	;; Org-Mode
	"o"  '(:ignore t :which-key "Org Mode")
	"oa" 'org-agenda
	"oc" 'org-capture
	"ol" 'org-store-link
	"od" 'org-deadline
	"os" 'org-schedule
	"op" 'org-set-property
	"ot" 'org-todo
	"oq" 'org-archive-subtree
	"or" 'org-refile
	"on" 'org-add-note
	"o;"  '(:ignore t :which-key "Org Clock")
	"o;i" 'org-clock-in
	"o;o" 'org-clock-out
	"o;d" 'org-clock-display
	"o;j" 'org-clock-goto
	)
      (general-def 'normal doc-view-mode-map
	"j"  'doc-view-next-line-or-next-page
	"k"  'doc-view-previous-line-or-previous-page
	"gg"  'doc-view-first-page
	"G"  'doc-view-last-page
	"C-d" 'doc-view-scroll-up-or-next-page
	"C-f" 'doc-view-scroll-up-or-next-page
	"C-b" 'doc-view-scroll-down-or-previous-page
	)
      (general-def 'normal package-menu-mode-map
	"i"  'package-menu-mark-install
	"U"  'package-menu-mark-upgrades
	"d"  'package-menu-mark-delete
	"u"  'package-menu-mark-unmark
	"x"  'package-menu-execute
	)
      )
#+end_src
* Org
#+begin_src emacs-lisp
    (use-package org
      :ensure org-plus-contrib
      :pin org
      :custom-face
      (org-ellipsis ((t (:underline nil))))
      :config
      (require 'org-habit)
      (add-to-list 'org-modules 'org-habit)
      (setq
       org-habit-graph-column 60
       org-confirm-babel-evaluate nil
       org-image-actual-width nil
       org-ellipsis "▼"
       org-agenda-window-setup 'only-window ; Full screeen agenda
       org-agenda-include-diary t
       org-agenda-skip-additional-timestamps-same-entry t
       org-agenda-skip-scheduled-if-done t
       org-agenda-skip-deadline-if-done t
       org-agenda-skip-timestamp-if-done t
       org-log-done 'time
       org-log-into-drawer t
       org-hide-emphasis-markers t
       org-directory "~/Org"
       org-default-notes-file (concat org-directory "/notes.org")
       org-agenda-files (list "~/Org"
			      )
       org-refile-use-outline-path 'file
       org-support-shift-select t
       org-refile-targets
       '((nil :maxlevel . 1)
	 (org-agenda-files :maxlevel . 1))
       org-format-latex-options (plist-put org-format-latex-options :scale 2.0)
       org-enforce-todo-checkbox-dependencies t
       org-agenda-span 30
       org-habit-show-habits-only-for-today nil
       org-archive-location "~/Org/archive.org::* From %s"
       )
      ;; Save Org buffers after refiling!
      (advice-add 'org-refile :after 'org-save-all-org-buffers)
      ;; Comonly Knows Tags
      (setq org-tag-alist
	    '((:startgroup)
	      ;; Put mutually exclusive tags here
	      (:endgroup)
	      ("@errand" . ?E)
	      ("@home" . ?H)
	      ("@work" . ?W)
	      ("agenda" . ?a)
	      ("planning" . ?p)
	      ("publish" . ?P)
	      ("batch" . ?b)
	      ("note" . ?n)
	      ("idea" . ?i)
	      )
	    )
      ;; Configure custom agenda views
      ;; (setq org-agenda-custom-commands
      ;; 	    '(("d" "Dashboard"
      ;; 	       ((agenda "" ((org-deadline-warning-days 7)))
      ;; 		(todo "NEXT"
      ;; 		      ((org-agenda-overriding-header "Next Tasks")))
      ;; 		(tags-todo "agenda/ACTIVE" ((org-agenda-overriding-header "Active Projects")))))
  
      ;; 	      ("n" "Next Tasks"
      ;; 	       ((todo "NEXT"
      ;; 		      ((org-agenda-overriding-header "Next Tasks")))))
  
      ;; 	      ("W" "Work Tasks" tags-todo "+work-email")
  
      ;; 	      ;; Low-effort next actions
      ;; 	      ("e" tags-todo "+TODO=\"NEXT\"+Effort<15&+Effort>0"
      ;; 	       ((org-agenda-overriding-header "Low Effort Tasks")
      ;; 		(org-agenda-max-todos 20)
      ;; 		(org-agenda-files org-agenda-files)))
  
      ;; 	      ("w" "Workflow Status"
      ;; 	       ((todo "WAIT"
      ;; 		      ((org-agenda-overriding-header "Waiting on External")
      ;; 		       (org-agenda-files org-agenda-files)))
      ;; 		(todo "REVIEW"
      ;; 		      ((org-agenda-overriding-header "In Review")
      ;; 		       (org-agenda-files org-agenda-files)))
      ;; 		(todo "PLAN"
      ;; 		      ((org-agenda-overriding-header "In Planning")
      ;; 		       (org-agenda-todo-list-sublevels nil)
      ;; 		       (org-agenda-files org-agenda-files)))
      ;; 		(todo "BACKLOG"
      ;; 		      ((org-agenda-overriding-header "Project Backlog")
      ;; 		       (org-agenda-todo-list-sublevels nil)
      ;; 		       (org-agenda-files org-agenda-files)))
      ;; 		(todo "READY"
      ;; 		      ((org-agenda-overriding-header "Ready for Work")
      ;; 		       (org-agenda-files org-agenda-files)))
      ;; 		(todo "ACTIVE"
      ;; 		      ((org-agenda-overriding-header "Active Projects")
      ;; 		       (org-agenda-files org-agenda-files)))
      ;; 		(todo "COMPLETED"
      ;; 		      ((org-agenda-overriding-header "Completed Projects")
      ;; 		       (org-agenda-files org-agenda-files)))
      ;; 		(todo "CANC"
      ;; 		      ((org-agenda-overriding-header "Cancelled Projects")
      ;; 		       (org-agenda-files org-agenda-files)
      ;; 		       )
      ;; 		      )
      ;; 		)
      ;; 	       )
      ;; 	      )
      ;; 	    )
      (setq org-todo-keywords
	    '((sequence "TODO(t)" "NEXT(n)" "|" "DONE(d)")
	      (sequence "PROJECT(p/!)" "|" "COMPLETED(c/!)" "ABORTED(a@/!0")
	      (sequence "WAITING(W@/!)" "DELEGATED(D@/!)" "|" "POSTPONE(P@/!)")
	      )
	    )
      :general
      (:keymaps 'org-agenda-mode-map
		"j" 'org-agenda-next-line
		"k" 'org-agenda-previous-line
		"s" 'org-agenda-schedule
		"d" 'org-agenda-deadline
		"i" 'org-clock-in
		"o" 'org-clock-out
		;; "r" 'org-agenda-refile
		"p" 'org-agenda-set-property
		"x" 'org-agenda-archive
		"n" 'org-agenda-add-note
		)
      )
    (setq org-deadline-warning-days 30)
  (use-package org-bullets
    :after org
    :hook (org-mode . org-bullets-mode)
    )
  (dolist (face '(
		    (org-level-1 . 1.5)
		    (org-level-2 . 1.1)
		    (org-level-3 . 1.05)
		    (org-level-4 . 1.0)
		    (org-level-5 . 0.9)
		    (org-level-6 . 0.9)
		    (org-level-7 . 0.9)
		    (org-level-8 . 0.9)
		    )
		  )
      (set-face-attribute (car face) nil  :weight 'regular :height (cdr face)
			  )
      )
    (use-package org-autolist
      :config
      (org-autolist-mode)
      )
#+end_src
** Capture
#+begin_src emacs-lisp
  (setq org-capture-templates
	'(
	  ("i" "Inbox" entry (file "~/Org/inbox.org")
	   "* %i%? \n")
	  ("e" "Enigma Todo" entry (file+headline "~/Dropbox/EnigmaOrg/Enigma.org" "Inbox")
	   "* TODO  %:subject %i%? \nSCHEDULED: %t \n:PROPERTIES: \n:CREATED: %T \n:END: \n %a ")
	  ("t" "Todo" entry (file+headline "~/Org/inbox.org" "Inbox")
	   "* TODO  %:subject %i%? \nSCHEDULED: %t \n:PROPERTIES: \n:CREATED: %T \n:END: \n %a ")
	  ("j" "Journal" entry (file "~/Org/journal.org")
	   "* TODO %i%? \n:PROPERTIES: \n:CREATED: %U \n:END: \n ")
	  ("p" "Project" entry(file "~/Org/gtd.org")
	   (file "~/.emacs.d/org-templates/project.org"))
	  ("P" "Enigma Project" entry(file "~/Dropbox/EnigmaOrg/Enigma.org")
	   (file "~/.emacs.d/org-templates/project.org"))
	  )
	)


  ;; SRC: cestlaz.github.io/posts/using-emacs-24-capture-2/

  (defadvice org-capture-finalize
      (after delete-capture-frame activate)
    "Advise capture-finalize to close the frame"
    (if (equal "capture" (frame-parameter nil 'name))
	(delete-frame)))

  (defadvice org-capture-destroy
      (after delete-capture-frame activate)
    "Advise capture-destroy to close the frame"
    (if (equal "capture" (frame-parameter nil 'name))
	(delete-frame)))

  (use-package noflet
    :ensure t )
  (defun make-capture-frame ()
    "Create a new frame and run org-capture."
    (interactive)
    (make-frame '((name . "capture")))
    (select-frame-by-name "capture")
    (delete-other-windows)
    (noflet ((switch-to-buffer-other-window (buf) (switch-to-buffer buf)))
      (org-capture)))
#+end_src
** functions and hooks
#+begin_src emacs-lisp
  (add-hook 'focus-in-hook
	    (lambda () (progn
			 (setq org-tags-column (- 5 (window-body-width)))) (org-align-all-tags)))
  (defun org-update-cookies-after-save()  ;; Updates all [/] and [%] cookies at save
    (interactive)
    (let ((current-prefix-arg '(4)))
      (org-update-statistics-cookies "ALL")))
  (add-hook 'org-mode-hook
	    (lambda ()
	      (add-hook 'before-save-hook 'org-update-cookies-after-save nil 'make-it-local)))
  (setq org-checkbox-hierarchical-statistics nil)


  ;; (defun org-summary-todo (n-done n-not-done)
  ;;    "Switch entry to DONE when all subentries are done, to TODO otherwise."
  ;;     (let (org-log-done org-log-states)   ; turn off logging
  ;;       (org-todo (if (= n-not-done 0) "DONE" "TODO"))))

  (add-hook 'org-after-todo-statistics-hook 'org-summary-todo)

  (defun org-checkbox-todo()
      "Switch header TODO state to DONE when all checkboxes are ticked, to TODO otherwise"
      (let ((todo-state (org-get-todo-state)) beg end)
	(unless (not todo-state)
	  (save-excursion
	    (org-back-to-heading t)
	(setq beg (point))
	(end-of-line)
	(setq end (point))
	(goto-char beg)
	(if (re-search-forward "\\[\\([0-9]*%\\)\\]\\|\\[\\([0-9]*\\)/\\([0-9]*\\)\\]"
			       end t)
	    (if (match-end 1)
		(if (equal (match-string 1) "100%")
		(unless (string-equal todo-state "DONE")
		  (org-todo 'done))
	      (unless (string-equal todo-state "TODO")
		(org-todo 'todo)))
	    (if (and (> (match-end 2) (match-beginning 2))
		       (equal (match-string 2) (match-string 3)))
		  (unless (string-equal todo-state "DONE")
		(org-todo 'done))
	      (unless (string-equal todo-state "TODO")
	      (org-todo 'todo)))))))))

  (add-hook 'org-checkbox-statistics-hook 'org-checkbox-todo)
 #+end_src
** org-habit-plus
 #+begin_src emacs-lisp
   ;; ;; Tell emacs where is your personal elisp lib dir
   ;;(add-to-list 'load-path "~/.emacs.d/lisp/")
   ;; ;; load the packaged named xyz.
   ;;(load "org-habit-plus") ;; best not to include the ending “.el” or “.elc”
   ;; (add-to-list 'org-modules 'org-habit)
  ;; (add-to-list 'org-modules 'org-habit-plus)
 #+END_SRC
** TODO Clocking Time
   #+begin_src emacs-lisp
     (setq org-clock-persist 'history)
     (setq org-clock-display-default-range 'thisweek)
     (setq org-clock-report-include-clocking-task t)
     (org-clock-persistence-insinuate)
     (setq org-duration-format 'h:mm)
   #+end_src
** Visual Fill Column
    #+begin_src emacs-lisp
      (defun efs/org-mode-visual-fill ()
	(setq visual-fill-column-width 100
	      visual-fill-column-center-text t)
	(visual-fill-column-mode 1))

      (use-package visual-fill-column
	:hook (org-mode . efs/org-mode-visual-fill))
    #+end_src

** Calendar
   #+begin_src emacs-lisp
     (setq diary-file "~/Org/diary")
     (setq calendar-date-style 'iso)
     (setq view-diary-entries-initially t
	   mark-diary-entries-in-calendar t
	   number-of-diary-entries 7)
     (add-hook 'diary-display-hook 'fancy-diary-display)
     (add-hook 'today-visible-calendar-hook 'calendar-mark-today)
   #+end_src
** Roam
   #+begin_src emacs-lisp
     (use-package org-roam
       :init
       (setq org-roam-v2-ack t)
       :custom
       (org-roam-directory "~/Roam")
       (org-roam-completion-everywhere t)
       :general
       (tyrant-def
	 "r"  '(:ignore t :which-key "Org Roam")
	 "rn" 'org-roam-buffer-toggle
	 "rf" 'org-roam-node-find
	 "ri" 'org-roam-node-insert
	 "ra" 'org-roam-alias-add
	 )
       :config
       (org-roam-setup)
       )
   #+end_src
*** Capture
    #+begin_src emacs-lisp
    #+end_src
* Ivy / Counsel
#+begin_src emacs-lisp
  (use-package ivy
    :general (
	      "C-s" 'swiper
	      )
    :config
    (ivy-mode 1))
  (use-package ivy-rich
    :after ivy
    :init
    (ivy-rich-mode 1)
    )
  (use-package counsel
    :custom
    (counsel-linux-app-format-function #'counsel-linux-app-format-function-name-only)
    :config
    (counsel-mode 1)
    )
#+end_src
* Doom mode line
#+begin_src emacs-lisp
  (use-package all-the-icons) ; run all-the-icons-install-fonts to install the fonts
  (use-package doom-modeline
    :init (doom-modeline-mode 1)
    (setq
     doom-modeline-icon (display-graphic-p)
     doom-modeline-height 15
     )
    )
#+end_src

* Which key
#+begin_src emacs-lisp
  (use-package which-key
    :init (which-key-mode)
    :diminish which-key-mode
    :config
    (setq which-key-idle-delay 1)
    )
#+end_src

* Helpful
  #+begin_src emacs-lisp
    (use-package helpful
      :init
      ;; Note that the built-in `describe-function' includes both functions
      ;; and macros. `helpful-function' is functions only, so we provide
      ;; `helpful-callable' as a drop-in replacement.
      (global-set-key (kbd "C-h f") #'helpful-callable)

      (global-set-key (kbd "C-h v") #'helpful-variable)
      (global-set-key (kbd "C-h k") #'helpful-key)
      )
  #+end_src

* Magit
#+begin_src emacs-lisp
  (use-package magit)
#+end_src
* Dashboard
  #+BEGIN_SRC emacs-lisp
  (use-package dashboard
    :init
    (setq dashboard-startup-banner 'logo
	  dashboard-show-shortcuts t
	  dashboard-set-heading-icons t
	  dashboard-set-init-info t
	  dashboard-set-file-icons t
	  )
    (setq dashboard-center-content t)
    :config
    (progn
      (dashboard-setup-startup-hook)
      (setq initial-buffer-choice (lambda () (get-buffer "*dashboard*")))
      )
  
    (setq dashboard-items '(
			    (projects . 20)
			    ;; (recents  . 5)
			    ;; (agenda . 20)
			    ;; (bookmarks . 5)
			    ;; (registers . 5)
			    )
	  )
    (setq show-week-agenda-p t)
    )
  ;;(add-to-list 'evil-emacs-state-modes 'dashboard-mode)
  ;; Format: "(icon title help action face prefix suffix)"
  (setq dashboard-navigator-buttons
	`(;; line1
	  ((,(all-the-icons-octicon "mark-github" :height 1.1 :v-adjust 0.0)
	    "Homepage"
	    "Browse homepage"
	    (lambda (&rest _) (browse-url "homepage")))
	   ("★" "Star" "Show stars" (lambda (&rest _) (show-stars)) warning)
	   ("?" "" "?/h" #'show-help nil "<" ">"))
	  ;; line 2
	  ((,(all-the-icons-faicon "linkedin" :height 1.1 :v-adjust 0.0)
	    "Linkedin"
	    ""
	    (lambda (&rest _) (browse-url "homepage")))
	   ("⚑" nil "Show flags" (lambda (&rest _) (message "flag")) error))))
  (defun dashboard-insert-custom (list-size)
    (insert "Custom text"))
  (add-to-list 'dashboard-item-generators  '(custom . dashboard-insert-custom))
  (add-to-list 'dashboard-items '(custom) t)
#+END_SRC

* Ranger
#+BEGIN_SRC emacs-lisp
    (use-package ranger
      :hook (after-init . ranger-override-dired-mode)
      :general (tyrant-def "R" 'ranger)
      )
#+END_SRC

* Try
  #+begin_src emacs-lisp
    (use-package try)
  #+end_src

* Format-All
#+BEGIN_SRC emacs-lisp
  (use-package format-all
    :general (tyrant-def ";" 'format-all-buffer)
    )
#+END_SRC
