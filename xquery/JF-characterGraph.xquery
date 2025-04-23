xquery version "3.1";

declare namespace svg = "http://www.w3.org/2000/svg";

<html>
  <head>
    <meta charset="UTF-8"/>
    <title>Character Frequency Visualization</title>
    <link type="text/css" href="styleV1.css" rel="stylesheet"/>
    <style>
      h1 {{
        text-align: center;
      }}

      body {{
        background-color: black;
        color: white;
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

      text {{
        fill: white;
      }}
    </style>
  </head>
  <body>
    <nav>
      <a href="index.html">Home</a>
      <a href="tonepage.html">Tone Analysis</a>
      <a href="character-Analysis.html">Character Analysis</a>
      <a href="about.html">About</a>
    </nav>

    <h1>Character Frequency Visualization</h1>

    {
      for $doc in collection("../xml/?select=*.xml")
      let $title := normalize-space($doc//title/string())
      let $refs := $doc//character/@ref/string()
      where count($refs) > 0

      let $norms := for $r in $refs return normalize-space(lower-case($r))
      let $distinct := distinct-values($norms)

      let $grouped :=
        for $name in $distinct
        let $count := count($norms[. = $name])
        let $display := (
          for $char in $doc//character
          let $ref := normalize-space(lower-case($char/@ref))
          where $ref = $name
          return normalize-space(string($char))
        )[1]
        order by $count descending
        return <group>
          <name>{ if ($display != "") then $display else "Unnamed" }</name>
          <count>{ $count }</count>
        </group>

      let $filtered := $grouped[xs:double(count) > 1]

      return (
        <h2>{ $title }</h2>,
        if (count($filtered) > 0) then (
          let $bar-width := 40,
              $bar-gap := 20,
              $max-height := 300,
              $max-count := max($filtered/count ! xs:double(.)),
              $svg-width := count($filtered) * ($bar-width + $bar-gap) + 50,
              $svg-height := $max-height + 70
          return (
            <p>Characters shown (appeared more than once): { count($filtered) }</p>,
            <svg:svg width="{ $svg-width }" height="{ $svg-height }" xmlns:svg="http://www.w3.org/2000/svg">
              {
                for $g at $pos in $filtered
                let $name := string($g/name)
                let $count := xs:double($g/count)
                let $height := $count div $max-count * $max-height
                let $x := ($pos - 1) * ($bar-width + $bar-gap)
                let $y := $max-height - $height

                let $words := tokenize($name, "\s+")
                let $truncated := if (count($words) > 3)
                                  then (subsequence($words, 1, 2) || ("…"))
                                  else $words

                return (
                  <svg:rect x="{ $x }" y="{ $y }" width="{ $bar-width }" height="{ $height }" fill="steelblue"/>,
                  for $word at $i in $truncated
                  return <svg:text x="{ $x + $bar-width div 2 }"
                                   y="{ $max-height + 25 + (($i - 1) * 12) }"
                                   font-size="10"
                                   text-anchor="middle">{ $word }</svg:text>,
                  <svg:text x="{ $x + $bar-width div 2 }" y="{ max((5, $y - 5)) }"
                            font-size="10" text-anchor="middle">{ $count }</svg:text>
                )
              }
            </svg:svg>
          )
        )
        else (
          <p>No characters appeared more than once in this story.</p>
        )
      )
    }
  </body>
</html>
