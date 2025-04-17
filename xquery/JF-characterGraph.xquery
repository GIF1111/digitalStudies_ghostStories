xquery version "3.1";

declare namespace svg = "http://www.w3.org/2000/svg";

<html>
  <head>
    <meta charset="UTF-8"/>
    <title>Character Frequency Visualization</title>
    <style>
      h1 {{
        text-align: center;
      }}
      
      body {{
    background-color: black;
    color: white;
    font-family: sans-serif;
      }}
  
    h1, h2, p {{
        color: white;
        text-align: center;
    }}
      svg {{
        margin-bottom: 40px;
        display: block;
        margin-left: auto;
        margin-right: auto;
      }}
      text{{
        fill: white;
    }}
    </style>
  </head>
  <body>
    <h1>Character Frequency Visualization</h1>

    {
      for $doc in collection("../xml/?select=*.xml")
      let $title := normalize-space($doc//title/string())
      let $refs := $doc//tone/string()
      where count($refs) > 0

      let $norms := for $r in $refs return normalize-space(lower-case($r))
      let $distinct := distinct-values($norms)

      let $grouped :=
        for $name in $distinct
        let $count := count($norms[. = $name])
        let $display := (
          for $tone in $doc//tone
          let $ref := normalize-space(lower-case($tone))
          where $ref = $name
          return normalize-space(string($char))
        )[1]
        order by $count descending
        return <group>
          <name>{ if ($display != "") then $display else "Unnamed" }</name>
          <count>{ $count }</count>
        </group>

      let $bar-width := 40
      let $bar-gap := 10
      let $max-height := 300
      let $max-count := max($grouped/count ! xs:double(.))
      let $svg-width := count($grouped) * ($bar-width + $bar-gap)
      let $svg-height := $max-height + 50

      return (
        <h2>{ $title }</h2>,
        <p>Characters found: { count($grouped) }</p>,
        <svg:svg width="{ $svg-width }" height="{ $svg-height }" xmlns:svg="http://www.w3.org/2000/svg">
          {
            for $g at $pos in $grouped
            let $name := string($g/name)
            let $count := xs:double($g/count)
            let $height := $count div $max-count * $max-height
            let $x := ($pos - 1) * ($bar-width + $bar-gap)
            let $y := $max-height - $height
            return (
              <svg:rect x="{ $x }" y="{ $y }" width="{ $bar-width }" height="{ $height }" fill="steelblue"/>,
              <svg:text x="{ $x + $bar-width div 2 }" y="{ $max-height + 25 }" font-size="10" text-anchor="end"
  transform="rotate(45, { $x + $bar-width div 2 }, { $max-height + 25 })">{ $name }</svg:text>,
              <svg:text x="{ $x + $bar-width div 2 }" y="{ max((5, $y - 5)) }" font-size="10" text-anchor="middle">{ $count }</svg:text>            )
          }
        </svg:svg>
      )
    }
  </body>
</html>
