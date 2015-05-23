(prelude-require-package 'netrc)
(prelude-require-package 'org2blog)

(require 'netrc)
(require 'org2blog)
(require 'auth-source)
(setq abg-devblog-credentials (auth-source-user-and-password "devblog.avdi.org"))
(setq org2blog/wp-blog-alist
      `(("virtuouscode"
             :url "http://devblog.avdi.org/xmlrpc.php"
             :username ,(car abg-devblog-credentials)
             :password ,(cadr abg-devblog-credentials)
             :tags-as-categories nil)))

;; See https://github.com/punchagan/org2blog/issues/89#issuecomment-8013355
(setq xml-entity-alist
      '(("lt"   . "&#60;")
        ("lt"   . "<")
        ("gt"   . ">")
        ("apos" . "'")
        ("quot" . "\"")
        ("amp"   . "&#38;")
        ("amp"  . "&")))
