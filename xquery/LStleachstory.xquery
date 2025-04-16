xquery version "3.1";

declare namespace svg = "http://www.w3.org/2000/svg";
declare namespace xlink = "http://www.w3.org/1999/xlink";

(: Replace this with the filename for each story :)
let $current := doc("../xml/the_poor_clare.xml")/story

let $highlight := distinct-values($current//year[normalize-space()])

let $stories := collection('../xml/?select=*.xml')/story

let $all :=
  for $s in $stories
  let $title := normalize-space($s/title)
  let $file := lower-case(translate(replace($title, "[^A-Za-z0-9 ]", ""), " ", "-")) || ".html"
  for $y in $s//year
  let $year := normalize-space($y)
  where matches($year, '^\d{3,4}$')
  return map {
    "year": $year,
    "title": $title,
    "file": $file
  }

let $unique :=
  for $y in distinct-values($all?year)
  let $entry := head(for $e in $all where $e?year = $y return $e)
  order by xs:integer($entry?year)
  return $entry

let $count := count($unique)
let $spacing := 150
let $padding := 100
let $total-width := ($count - 1) * $spacing + (2 * $padding)

let $timeline :=
  for $entry at $i in $unique
  let $x := $padding + (($i - 1) * $spacing)
  let $is-highlight := $entry?year = $highlight
  let $dot-color := if ($is-highlight) then "red" else "blue"
  let $text-style := if ($is-highlight) then "font-weight:bold;" else ""
  return (
    <circle cx="{$x}" cy="50" r="5" fill="{$dot-color}">
      <title>{$entry?title}</title>
    </circle>,
    <a xlink:href="{$entry?file}">
      <text x="{$x}" y="70" font-size="12" text-anchor="middle" fill="white" style="{$text-style}">
        <title>{$entry?title}</title>
        {$entry?year}
      </text>
    </a>
  )

return
<svg xmlns="http://www.w3.org/2000/svg"
     xmlns:xlink="http://www.w3.org/1999/xlink"
     width="{$total-width}" height="100">
  <text x="{$total-width div 2}" y="30" font-size="20" font-weight="bold" text-anchor="middle">
  </text>
  <line x1="{$padding}" y1="50" x2="{$total-width - $padding}" y2="50" stroke="white" stroke-width="2"/>
  {
    $timeline
  }
</svg>
