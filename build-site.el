
;;; build-site.el --- Build homepage from Org using org-publish -*- lexical-binding: t; -*-

(require 'ox-publish)

;; （任意）Orgが生成するデフォルトCSSを埋め込まない
(setq org-html-head-include-default-style nil)

(setq org-publish-project-alist
      (list
       ;; Org -> HTML
       (list "home-org"
             :recursive t
             :base-directory "./content"
             :publishing-directory "./docs"
             :publishing-function 'org-html-publish-to-html

             ;; CSSリンクは相対パスで（docs/ から見て docs/static/... を指す）
             :html-head "<link rel=\"stylesheet\" href=\"static/css/style.css\" />\n"
             :html-head-include-default-style nil

	     ;; ★ postamble を「© 藤本教寛（沖縄高専）」だけにする
	     :html-postamble "<p class=\"author\">&copy; 藤本教寛（沖縄高専） / Yukihiro Fujimoto (Okinawa KOSEN)</p></div>\n"
	     )

       ;; Static -> docs/static 以下へコピー（階層を保持）
       (list "home-static"
             :recursive t
             :base-directory "./static"
             :publishing-directory "./docs/static"
             :publishing-function 'org-publish-attachment

             ;; （任意）コピー対象を絞る：必要なら拡張子を追加
             :base-extension "css\\|js\\|png\\|jpg\\|jpeg\\|gif\\|svg\\|webp\\|ico\\|pdf\\|woff\\|woff2\\|ttf\\|otf")

       ;; Meta project
       (list "home"
             :components '("home-org" "home-static"))))

;; Force publish all
(org-publish-all t)

(message "Build complete!")
