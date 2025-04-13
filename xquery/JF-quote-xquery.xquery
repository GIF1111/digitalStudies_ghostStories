xquery version "3.1";

for $doc in collection("../xml/?select=*.xml")
let $title := $doc//title/string()

(: Join all paragraph text into one string :)
let $all-text := string-join($doc//p, " ")
let $total-length := string-length($all-text)

(: Join all <quote> elements inside paragraphs :)
let $all-quotes := string-join($doc//p//quote, " ")
let $quote-length := string-length($all-quotes)

let $percentage :=
  if ($total-length > 0)
  then round(($quote-length div $total-length) * 100)
  else 0
(: 0 in the output means that there was no quotes in that story:)

return
  <story>
    <title>{ $title }</title>
    <dialogue-percentage>{ $percentage }%</dialogue-percentage>
  </story>