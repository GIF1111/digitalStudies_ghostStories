xquery version '3.1';

declare namespace svg = "http://www.w3.org/2000/svg";


(: Collect all tone attributes :)
let $tones := (
    for $doc in collection("../xml/?select=*.xml")
    return $doc//title/@tone/string()
)
    
(: Create a map counting occurrences of each tone :)
let $tone-counts := map:merge(
    for $tone in distinct-values($tones)
    return map:entry($tone, count($tones[. eq $tone]))
)


let $max-count := max((map:keys($tone-counts) ! $tone-counts(.), 0))

(: Generate SVG :)
let $svg :=
    <svg xmlns="http://www.w3.org/2000/svg" width="400" height="300">
        <!-- Y-axis labels and grid lines -->
        <g transform="translate(50,10)">
            { for $y in 0 to 10
              let $y-pos := 250 - ($y * 20)
              return (
                <text x="-10" y="{$y-pos}" text-anchor="end" font-size="10">{ $y }</text>,
                <line x1="0" y1="{$y-pos}" x2="350" y2="{$y-pos}" stroke="lightgrey" stroke-width="1" />
                (:line between each increment:)
              )
            }
            
            <!-- X-axis labels -->
            { for $tone at $index in distinct-values($tones)
              let $x-pos := ($index - 1) * 30 + 20
              return <text x="{$x-pos}" y="270" text-anchor="middle" font-size="10">{ $tone }</text>
            }
            
            <!-- Bars -->
            { for $tone at $index in distinct-values($tones)
              let $count := map:get($tone-counts, $tone)
              let $x-pos := ($index - 1) * 30 + 10
              let $bar-height := ($count * 20)
              return <rect x="{$x-pos}" y="{250 - $bar-height}" width="20" height="{$bar-height}" fill="steelblue" />
            }
        </g>
    </svg>

return $svg