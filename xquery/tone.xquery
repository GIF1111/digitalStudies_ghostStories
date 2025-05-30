xquery version "3.1";

declare namespace svg = "http://www.w3.org/2000/svg";

<html>
  <head>
    <meta charset="UTF-8"/>
    <title>Tone Frequency Visualization</title>
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

    <h1>Tone Frequency Visualization</h1>

    {
      for $doc in collection("../xml/?select=*.xml")
      let $title := normalize-space($doc//title/string())
      let $tones := $doc//p/@tone/string()
      where count($tones) > 0

      let $norms := for $t in $tones return normalize-space(lower-case($t))
      let $distinct := distinct-values($norms)

      let $grouped :=
        for $tone in $distinct
        let $count := count($norms[. = $tone])
        order by $count descending
        return <group>
          <tone>{ $tone }</tone>
          <count>{ $count }</count>
        </group>

      let $bar-width := 40
      let $bar-gap := 10
      let $max-height := 300
      let $max-count := max($grouped/count ! xs:double(.))
      let $svg-width := count($grouped) * ($bar-width + $bar-gap) + 50
      let $svg-height := $max-height + 50

      return (
        <h2>{ $title }</h2>,
        <p>Tones found: { count($grouped) }</p>,
        <svg:svg width="{ $svg-width }" height="{ $svg-height }" xmlns:svg="http://www.w3.org/2000/svg">
          {
            for $g at $pos in $grouped
            let $tone := string($g/tone)
            let $count := xs:double($g/count)
            let $height := $count div $max-count * $max-height
            let $x := ($pos - 1) * ($bar-width + $bar-gap)
            let $y := $max-height - $height
            return (
              <svg:rect x="{ $x }" y="{ $y }" width="{ $bar-width }" height="{ $height }" fill="steelblue"/>,
              <svg:text x="{ $x + $bar-width div 2 }" y="{ $max-height + 25 }" font-size="10" text-anchor="middle">{ $tone }</svg:text>,
              <svg:text x="{ $x + $bar-width div 2 }" y="{ max((5, $y - 5)) }" font-size="10" text-anchor="middle">{ $count }</svg:text>
            )
          }
        </svg:svg>
      )
    }
  </body>
</html>
