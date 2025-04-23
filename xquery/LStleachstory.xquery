xquery version "3.1";

declare namespace svg = "http://www.w3.org/2000/svg";
declare namespace xlink = "http://www.w3.org/1999/xlink";

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
    element svg:circle {
      attribute cx { $x },
      attribute cy { "50" },
      attribute r { "5" },
      attribute fill { $dot-color },
      element svg:title { $entry?title }
    },
    element svg:a {
      attribute xlink:href { $entry?file },
      element svg:text {
        attribute x { $x },
        attribute y { "70" },
        attribute font-size { "12" },
        attribute text-anchor { "middle" },
        attribute fill { "white" },
        attribute style { $text-style },
        element svg:title { $entry?title },
        $entry?year
      }
    }
  )

return
element svg:svg {
  attribute width { $total-width },
  attribute height { "100" },
  element svg:text {
    attribute x { $total-width div 2 },
    attribute y { "30" },
    attribute font-size { "20" },
    attribute font-weight { "bold" },
    attribute text-anchor { "middle" }
  },
  element svg:line {
  attribute x1 { $padding },
  attribute y1 { "50" },
  attribute x2 { $total-width - $padding },
  attribute y2 { "50" },
  attribute stroke { "white" },
  attribute { QName("", "stroke-width") } { "2" }

  },
  $timeline
}
