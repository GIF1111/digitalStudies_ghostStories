xquery version "3.1";

(: Load documents :)
let $docs := collection("..\\xml?select=*.xml")

(: Group stories by unique title and tone :)
let $grouped :=
  for $story in $docs//story[title/@tone]
  let $title := normalize-space($story/title)
  let $tone := $story/title/@tone/string()
  group by $key := concat($title, "::", $tone)
  order by $tone
  return
    let $raw-names := $story//character/text()
    
    (: Build a map of normalized → original names :)
    let $normalized := distinct-values(
      for $name in $raw-names
      let $clean := normalize-space($name)
      where string-length($clean) > 0
      return lower-case($clean)
    )

    let $name-map := 
      for $name in $raw-names
      let $clean := normalize-space($name)
      let $key := lower-case($clean)
      group by $k := $key
      return head($clean)  (: first instance of nicely-cased name :)

    return
      <div>
        <h2>{substring-before($key, "::")} (Tone: {substring-after($key, "::")})</h2>
        <ul>
          {
            for $name in sort(distinct-values($name-map))
            return <li>{$name}</li>
          }
        </ul>
      </div>

return
<html>
  <head>
    <title>Characters by Story</title>
    <style>
      h2 {{ color: darkslategray; margin-top: 2em; }}
      ul {{ margin-left: 20px; }}
    </style>
  </head>
  <body>
    <h1>Characters by Story (Sorted by Tone)</h1>
    { $grouped }
  </body>
</html>
