xquery version "3.1";

declare namespace svg = "http://www.w3.org/2000/svg";

(: Load the story :)
let $story := doc("../xml/curious_if_true.xml")/story

(: Count tones :)
let $tones := $story//p/@tone/string()
let $distinct := distinct-values($tones)

let $counts :=
  for $t in $distinct
  let $count := count($tones[. = $t])
  order by $count descending
  return map { "tone": $t, "count": $count }

(: SVG settings :)
let $bar-width := 40
let $bar-gap := 20
let $bar-max-height := 150
let $max := max($counts?count)
let $svg-width := count($counts) * ($bar-width + $bar-gap) + $bar-gap
let $svg-height := $bar-max-height + 60

(: Bars :)
let $bars :=
  for $bar at $i in $counts
  let $tone := $bar?tone
  let $count := $bar?count
  let $x := $bar-gap + (($i - 1) * ($bar-width + $bar-gap))
  let $height := xs:decimal($count) div $max * $bar-max-height
  let $y := $bar-max-height - $height + 20
  return (
    <rect x="{$x}" y="{$y}" width="{$bar-width}" height="{$height}"
          fill="steelblue">
      <title>{$tone} ({$count})</title>
    </rect>,
    <text x="{$x + $bar-width div 2}" y="{$bar-max-height + 35}" 
          font-size="12" text-anchor="middle">{$tone}</text>,
    <text x="{$x + $bar-width div 2}" y="{$y - 5}" 
          font-size="10" text-anchor="middle">{$count}</text>
  )

return
<svg xmlns="http://www.w3.org/2000/svg"
     width="{$svg-width}" height="{$svg-height}">
  <text x="{$svg-width div 2}" y="15"
        font-size="16" font-weight="bold" text-anchor="middle">
    Tone Frequency
  </text>
  {
    $bars
  }
</svg>
