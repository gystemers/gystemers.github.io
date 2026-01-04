
;;; build-site.el --- Build homepage from Org using org-publish -*- lexical-binding: t; -*-

(require 'ox-publish)

;; （任意）Orgが生成するデフォルトCSSを埋め込まない
(setq org-html-head-include-default-style nil)

;; ★ postamble等に出る日時のフォーマット（ビルド日時 %T の見た目）
;; org-html-metadata-timestamp-format は preamble/postamble/metadata のタイムスタンプ書式に使われる [3](https://github.com/gongzhitaao/orgcss)
(setq org-html-metadata-timestamp-format "%Y-%m-%d")

;; ★ postamble をフォーマットで生成する
;; %T は「エクスポート時刻（ビルド時刻）」 [1](https://emacsdocs.org/docs/org/Publishing-options)

(setq org-html-postamble-format
      '(("ja" "<p class=\"postamble\">&copy; 藤本教寛（沖縄高専） / Yukihiro Fujimoto (Okinawa KOSEN) &nbsp;|&nbsp; 最終更新: %C</p>\n")
        ("en" "<p class=\"postamble\">&copy; Yukihiro Fujimoto (Okinawa KOSEN) &nbsp;|&nbsp; Last updated: %C</p>\n")))

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
             ;; ★ postamble を有効化：t にすると org-html-postamble-format を使う [2](https://orgmode.org/manual/CSS-support.html)
             :html-postamble t)

       ;; Static -> docs/static 以下へコピー（階層を保持）
       (list "home-static"
             :recursive t
             :base-directory "./static"
             :publishing-directory "./docs/static"
             :publishing-function 'org-publish-attachment
             :base-extension "css\\|js\\|png\\|jpg\\|jpeg\\|gif\\|svg\\|webp\\|ico\\|pdf\\|woff\\|woff2\\|ttf\\|o")
       ;; Meta project
       (list "home"
             :components '("home-org" "home-static"))))

;; Force publish all
(org-publish-all t)

(message "Build complete!")
