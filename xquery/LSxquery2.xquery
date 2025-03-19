xquery version "3.1";

(: Load all XML files from the XML folder :)
let $docs := collection("..\xml?select=*.xml")

(: Extract all speech elements from all XML documents :)
let $speeches := $docs//p

(: Extract all character names from speech elements :)
let $distinct-char := distinct-values($speeches//character/text())

(: Process each character and count occurrences :)
let $results := 
  for $speaker in $distinct-char
  let $char-count := count($speeches[character = $speaker])
  where $char-count >= 1
  order by $char-count descending
  return 
    <tr>
      <td>{$speaker}</td>
      <td>{$char-count}</td>
    </tr>

(: Output the results in HTML format :)
return 
  <html>
    <head>
      <title>Character Speech Count</title>
      <style>
        table {{ border-collapse: collapse; width: 50%; }}
        th, td {{ border: 1px solid black; padding: 8px; text-align: left; }}
        th {{ background-color: #f2f2f2; }}
      </style>
    </head>
    <body>
      <h1>Character Speech Count</h1>
      <table>
        <tr>
          <th>Character Name</th>
          <th>Speech Count</th>
        </tr>
        { $results }
      </table>
    </body>
  </html>
