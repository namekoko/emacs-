(add-to-list 'load-path (expand-file-name "~/.emacs.d/site-lisp"))

;;background color
(custom-set-faces
 '(default ((t (:background "#000022" :foreground "#FFFFF0"))))
 '(cursor (
           (((class color) (background dark )) (:background "#00AA00"))
           (((class color) (background light)) (:background "#999999"))
           (t ())
           ))
 )

;; フレーム透過設定
;; defalt window (50%)
(add-to-list 'default-frame-alist '(alpha . 85))
;; current window (85%)
(set-frame-parameter nil 'alpha 85)


;;カーソル関係の設定
;;カーソルの色を指定
(setq default-frame-alist
      (append (list '(cursor-color ."white")) default-frame-alist))
;;行数常に表示
(global-linum-mode t)
;;; 対応する括弧を光らせる。
(show-paren-mode 1)
 ;;; カーソルの点滅を止める
(blink-cursor-mode 0)
;;; カーソルの位置が何文字目かを表示する
(column-number-mode t)
;;; カーソルの位置が何行目かを表示する
(line-number-mode t)
;;カーソル日本語入ONOFF
(defun mac-selected-keyboard-input-source-change-hook-func ()
  ;; 入力モードが英語の時はカーソルの色をfirebrickに、日本語の時はblackにする
  (set-cursor-color (if (string-match "\\.US$" (mac-input-source))
                        "firebrick" "black")))

(add-hook 'mac-selected-keyboard-input-source-change-hook
          'mac-selected-keyboard-input-source-change-hook-func)


;;マジックコメントを消す
(require 'ruby-mode)
(defun ruby-mode-set-encoding () nil)

;;Rの設定20151129
(add-to-list 'load-path "/Users/eri/.emacs.d/ess-15.09-2/lisp")
(load "ess-site")

(set-locale-environment "utf-8")
(setenv "LANG" "ja_JP.UTF-8")


;;;るびきち パッケージの設定
;;; 右から左に読む言語に対応させないことで描画高速化
(setq-default bidi-display-reordering nil)
;;; splash screenを無効にする
(setq inhibit-splash-screen t)
;;; 同じ内容を履歴に記録しないようにする
(setq history-delete-duplicates t)
;; C-u C-SPC C-SPC …でどんどん過去のマークを遡る
(setq set-mark-command-repeat-pop t)
;;; 釣合う括弧をハイライトする
(show-paren-mode 1)
;;; インデントにTABを使わないようにする
(setq-default indent-tabs-mode nil)
;;; 現在行に色をつける
(global-hl-line-mode t)
(custom-set-faces
'(hl-line ((t (:background "color-236"))))
)
;;; ミニバッファ履歴を次回Emacs起動時にも保存する
(savehist-mode 1)
;;; シェルに合わせるため、C-hは後退に割り当てる
;;(global-set-key (kbd “C-h”) ‘delete-backward-char)
;;; モードラインに時刻を表示する
 (display-time)
;;; 行番号・桁番号を表示する
(line-number-mode 1)
(column-number-mode 1)
;; GCを減らして軽くする
(setq gc-cons-threshold (* 10 gc-cons-threshold))
;;; ログの記録行数を増やす
(setq message-log-max 10000)
;;; 履歴をたくさん保存する
(setq history-length 1000)
;;; メニューバーとツールバーとスクロールバーを消す
 (menu-bar-mode -1)
 (tool-bar-mode -1)
 (scroll-bar-mode -1)
;; ==
(put 'upcase-region 'disabled nil)

;; 以下が Mac 用のフォント設定
(when (memq window-system '(mac ns))
  (global-set-key [s-mouse-1] 'browse-url-at-mouse)
  (let* ((size 14)
	 (jpfont "Hiragino Maru Gothic ProN")
	 (asciifont "Monaco")
	 (h (* size 10)))
    (set-face-attribute 'default nil :family asciifont :height h)
    (set-fontset-font t 'katakana-jisx0201 jpfont)
    (set-fontset-font t 'japanese-jisx0208 jpfont)
    (set-fontset-font t 'japanese-jisx0212 jpfont)
    (set-fontset-font t 'japanese-jisx0213-1 jpfont)
    (set-fontset-font t 'japanese-jisx0213-2 jpfont)
    (set-fontset-font t '(#x0080 . #x024F) asciifont))
  (setq face-font-rescale-alist
	'(("^-apple-hiragino.*" . 1.2)
	  (".*-Hiragino Maru Gothic ProN-.*" . 1.2)
	  (".*osaka-bold.*" . 1.2)
	  (".*osaka-medium.*" . 1.2)
	  (".*courier-bold-.*-mac-roman" . 1.0)
	  (".*monaco cy-bold-.*-mac-cyrillic" . 0.9)
	  (".*monaco-bold-.*-mac-roman" . 0.9)
	  ("-cdac$" . 1.3)))
  ;; C-x 5 2 で新しいフレームを作ったときに同じフォントを使う
  (setq frame-inherited-parameters '(font tool-bar-lines)))

;;yatex関係の設定016/11/15
;;; Package.el config
(require 'package)
(add-to-list 'package-archives '("melpa" . "http://melpa.org/packages/") t)
(add-to-list 'package-archives '("marmalade" . "http://marmalade-repo.org/packages/"))
(package-initialize)
;;「YaTeX がまだインストールされていなければインストールをしろ」 
(unless (package-installed-p 'yatex)
    (package-refresh-contents) (package-install 'yatex))


       


;; ;;最低限のyatexの設定
;; (autoload 'yatex-mode "yatex" "Yet Another LaTeX mode" t)
;; (setq auto-mode-alist
;;       (append '(("\\.tex$" . yatex-mode)
;;         ("\\.ltx$" . yatex-mode)
;;         ("\\.sty$" . yatex-mode)) auto-mode-alist))
;; ;; set YaTeX coding system
;; (setq YaTeX-kanji-code 4) ; UTF-8 の設定
;; (add-hook 'yatex-mode-hook
;;       '(lambda ()
;;          (setq YaTeX-use-AMS-LaTeX t) ; align で数式モードになる
;;          (setq YaTeX-use-hilit19 nil
;;            YateX-use-font-lock t)
;;          (setq tex-command "em-latexmk.sh") ; typeset command
;;          (setq dvi2-command "evince") ; preview command
;;          (setq tex-pdfview-command "xdg-open"))) ; preview command

;; ;;; Latexコンパイラなどの設定
;; (setq tex-command "ptex2pdf -l -ot -synctex=1 -file-line-error")
;; (setq dviprint-command-format "dvipdfmx %s")
;; (setq dvi2-command "/usr/bin/open -a Preview")  ;; use Preview.app
;; (setq bibtex-command "pbibtex")setq tex-command "platex-ng -synctex=1")
;; (setq dviprint-command-format "platex %s")
