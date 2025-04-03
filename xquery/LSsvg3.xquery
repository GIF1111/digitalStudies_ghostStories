declare option saxon:output "method=html";
declare option saxon:output "doctype-system=about:legacy-compat";

<html>
  <head>
    <title>Story Titles</title>
  </head>
  <body>
    <h1>Story Titles (Alphabetical)</h1>
    <ul>
      {
        for $doc in collection("..\\xml?select=*.xml")//title
        let $title := normalize-space($doc)
        let $filename := replace(base-uri($doc), '^.*[\\/](.+?)\.xml$', '$1.html')
        order by $title
        return <li><a href="{$filename}">{$title}</a></li>
      }
    </ul>
  </body>
</html>
