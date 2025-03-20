xquery version "3.1";

declare variable $xml := collection('xml/?select=*.xml');

let $doc := doc("../xml/DBest_the_grey_woman.xml")
(:Displays the xml file.:)

let $tone-type := $doc//title/@tone
(:Grabs the tone from the title since there is no tone attribute in paragraphs now.:)

for $paragraph in $doc//p
(:Looks through all of the paragraph elements.:)

where $tone-type = 'suspenseful'
(:Looks for "suspenseful" tones in the story.:) 
 
order by string-length($paragraph) descending
(:Ordered paragraphs from longest to shortest.:)

return
<suspenseful-paragraph>
    <text>{$paragraph/string()}</text>
    <tone type="{$tone-type}"/>
</suspenseful-paragraph>
(:Made a new element that groups all of the most suspenseful paragraphs.:)