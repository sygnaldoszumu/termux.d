;;;We’re going to set the load-path ourselves and avoid calling (package-initilize) (for performance reasons) so we need to set package--init-file-ensured to true to tell package.el to not automatically call it on our behalf. Additionally we’re setting package-enable-at-startup to nil so that packages will not automatically be loaded for us since use-package will be handling that.
(eval-and-compile
  (setq load-prefer-newer t
        package-user-dir "~/.emacs.d/elpa"  ;; User  scripts location
        package--init-file-ensured t
        package-enable-at-startup nil)
  (unless (file-directory-p package-user-dir)
    (make-directory package-user-dir t))
  (setq load-path (append load-path (directory-files package-user-dir t "^[^.]" t))))


(eval-when-compile
  (require 'package)
  ;; tells emacs not to load any packages before starting up
  ;; the following lines tell emacs where on the internet to look up
  ;; for new packages.
  (setq package-archives '(("melpa"  . "http://melpa.org/packages/")
                           ("elpa"  . "http://elpa.gnu.org/packages/")
                           ("org"  . "http://orgmode.org/elpa/")))
  ;; (package-initialize)
  (unless package--initialized (package-initialize t))

  ;; Bootstrap `use-package'
  (unless (package-installed-p 'use-package)
    (package-refresh-contents)
    (package-install 'use-package))

  ;; USE PACKAGE
  (require 'use-package)
  (setq use-package-always-ensure t)
  )

(org-babel-load-file (expand-file-name "./termux.org"))
