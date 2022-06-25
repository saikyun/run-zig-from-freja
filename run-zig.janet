(import freja/open-file)
(import freja/default-hotkeys :as dh)

(defn run
  [& args]
  (with [fout (file/open "out" :w)]
    (with [ferr (file/open "err" :w)]
      (with-dyns [:out fout
                  :err ferr]
        (os/execute args :p {:out fout :err ferr}))))

  (let [out (slurp "out")
        err (slurp "err")]
    (if-not (empty? err)
      (do
        (unless (empty? out) (print "out: " out))
        (error err))
      out)))

(defn build-exe
  [& args]
  (run "powershell" "-Command" "zig" "build-exe" ;args))

(dh/global-set-key [:right-control :r]
                   (fn [buffer]
                     (let [path (buffer :path) # e.g. "hello.zig"
                           exe-path (first (string/split "." path))] # e.g. "hello"
                       (try
                         (do
                           (build-exe path)
                           (print (run exe-path)))
                         ([err fib]
                           (eprint err)
                           (def [file line-number column] (string/split ":" err))
                           (open-file/open-file file
                                                (dec (scan-number line-number))
                                                (dec (scan-number column))))))))
