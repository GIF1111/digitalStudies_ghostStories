declare option saxon:output "method=html";
declare option saxon:output "doctype-system=about:legacy-compat";
declare variable $stories := collection('../xml/?select=*.xml');
declare variable $yspacer := 25;
declare variable $xspacer := 60;
declare variable $tone-colors := map{
    'happy' : 'green',
    'sad' : 'blue',
    'suspenseful' : 'purple',
    'angry' : 'red',
    'fear' : 'black' };
    
<html>
    <head>
        <title>Victorian Shost Story Timeline</title>
    </head>
        <p>This is meant to bring ghost stories to life by turning them into a visual timeline, with each story getting a color based on its mood.</p>

<svg xmlns="http://www.w3.org/2000/svg" width="100%" height="100%">
    <g transform="translate(150,100)">
    <g>
    <text x="0" y="-5" font-family="sans-serif" font-size="20px" fill="black">Victorian Ghost Story Timeline</text>
    </g>
    <g>
    
    <p>Each story is supposed to a colored circle based on its mood, and the circles are placed according to the year the story was written.</p>
    
        {        
            for $story in $stories
            let $title := $story//title
            let $year := $story//year
            let $tone := $story//tone
            let $color := if ($tone) then
            map:get($tone-colors, $tone) else 'gray'
            
            return
                <g>
                <circle cx="{$year - 1810 * $xspacer}" cy="{$year - 1810 * $yspacer}" r="10" fill="{$color}"/>
                <text x="{$year - 1810 * $xspacer}" y="{$year - 1810 * $yspacer + 20}" font-family="sans-serif" font-size="12px" fill="black" text-anchor="middle">{$title}</text>
                </g>
        }        
        </g>
    </g>
</svg>
</html>