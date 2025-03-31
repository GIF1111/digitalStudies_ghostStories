declare variable $stories := collection('?select=*.xml');
declare variable $yspacer := 25;
declare variable $xspacer := 60;
declare variable $tone-colors := map{
    'happy' : 'green',
    'sad' : 'blue',
    'suspenseful' : 'purple',
    'angry' : 'red',
    'dark' : 'black'};

<svg xmlns="http://www.w3.org/2000/svg" width="100%" height="100%">
    <g transform="translate(150,100)">
    <g>
    <text x="0" y="-5" font-family="sans-serif" font-size="20px" fill="black">Victorian Ghost Story Timeline</text>
    </g>
    <g>
        {
            for $story in $stories
            let $title := $story//title
            let $year := $story//year
            let $tone := $story//tone
            let $color := map:get($tone-colors, $tone)
            return
                <g>
                <circle cx="{$year - 1810 * $xspacer}" cy="{$year - 1810 * $yspacer}" r="10" fill="{$color}"/>
                <text x="{$year - 1810 * $xspacer}" y="{$year - 1810 * $yspacer + 20}" font-family="sans-serif" font-size="12px" fill="black" text-anchor="middle">{$title}</text>
                </g>
        }
        </g>
    </g>
</svg>