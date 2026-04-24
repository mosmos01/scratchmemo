;; ■ *scratch* をメモ代わりに使う。変更2026/02/15 11:13:21
;; *scratch* を終了時に保存
(add-hook '*kill-xyzzy-hook*
          #'(lambda ()
              (save-excursion
                (let ((buf (find-buffer "*scratch*")))
                  (when buf
                    (set-buffer buf)
                    (when (buffer-modified-p)
                      (write-file "~/scratch")
                      (unless (equal (point-min) (point-max))
                        (write-file
                         (format-date-string
                          "E:/memorandom/%Y_%m_%d_%H%M%S_scratch.lisp")))))))))

;; *scratch* を起動時にロード
(add-hook '*post-startup-hook*
          #'(lambda ()
              (save-excursion
                (let ((buf (find-buffer "*scratch*")))
                  (when buf
                    (set-buffer buf)
                    (insert-file-contents "~/scratch" t)
                    (set-buffer-modified-p nil))))))

;; *scratch* は kill させない
(add-hook '*query-kill-buffer-hook*
          #'(lambda ()
              (if (and (not *kill-buffer-kills-scratch*)
                       (equal (buffer-name (selected-buffer))
                              "*scratch*"))
                  nil
                t)))
