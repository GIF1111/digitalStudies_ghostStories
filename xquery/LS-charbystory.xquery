xquery version "3.1";

let $docs := collection("..\\xml?select=*.xml")//story[title/@tone]

let $grouped :=
  for $key in distinct-values(
    for $s in $docs
    let $title := normalize-space($s/title)
    let $tone := $s/title/@tone/string()
    return concat($title, "::", $tone)
  )
  let $title := substring-before($key, "::")
  let $tone := substring-after($key, "::")
  let $stories :=
    for $s in $docs
    where normalize-space($s/title) = $title and $s/title/@tone = $tone
    return $s

  let $all-characters :=
    for $s in $stories
    for $c in $s//character
    let $name := normalize-space($c)
    where string-length($name) > 0
    return $name

  let $distinct := distinct-values($all-characters)

  let $sorted :=
    for $name in $distinct
    order by lower-case($name)
    return $name

  return
    <div>
      <h2>{$title} (Tone: {$tone})</h2>
      <ul>
        {
          for $char in $sorted
          return <li>{$char}</li>
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
