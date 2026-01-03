;;; build-site.el --- Build homepage from Org using org-publish -*- lexical-binding: t; -*-
(require 'ox-publish)

(setq org-publish-project-alist
      (list
       ;; Org -> HTML
       (list "home-org"
             :recursive t
             :base-directory "./content"
             :publishing-directory "./docs"
             :publishing-function 'org-html-publish-to-html)

       ;; Static files (css, images, etc.) -> copy as-is
       (list "home-static"
             :recursive t
             :base-directory "./static"
             :publishing-directory "./docs"
             :publishing-function 'org-publish-attachment)

       ;; Meta project: publish both
       (list "home"
             :components '("home-org" "home-static"))))

;; Force publish all
(org-publish-all t)

(message "Build complete!")
