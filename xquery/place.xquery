xquery version "3.1";

let $stories := collection('../xml/?select=*.xml')/story

(: Gather all <place> elements with title and filename :)
let $entries :=
  for $s in $stories
  let $title := normalize-space($s/title)
  let $file := lower-case(translate(replace($title, "[^A-Za-z0-9 ]", ""), " ", "-")) || ".html"
  for $p in $s//place
  let $place := normalize-space($p)
  where $place != ""
  return map {
    "place": $place,
    "title": $title,
    "file": $file
  }

(: Group by place :)
let $places := distinct-values($entries?place)

return
<html>
  <head>
    <title>Story Places Index</title>
    <link rel="stylesheet" href="styleV1.css"/>
  </head>
  <body>
    <h1>Places Mentioned in Stories</h1>
    <table>
      <tr><th>Place</th><th>Stories</th></tr>
      {
        for $p in sort($places)
        let $related := 
          for $e in $entries
          where $e?place = $p
          return 
            <a href="{$e?file}">{$e?title}</a>
        return
          <tr>
            <td>{$p}</td>
            <td>{ $related }</td>
          </tr>
      }
    </table>
  </body>
</html>
    