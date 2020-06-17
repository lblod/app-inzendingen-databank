(define-resource search-query ()
  :class (s-prefix "searchToezicht:SearchQuery")
  :properties `((:label :string ,(s-prefix "skos:prefLabel"))
                (:comment :string ,(s-prefix "skos:comment")))
  :resource-base (s-url "http://lblod.data.gift/vocabularies/search-queries-toezicht/")
  :features `(include-uri)
  :on-path "search-queries")