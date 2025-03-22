xquery version "3.1";
declare option saxon:output "method=html";
declare variable $xml := collection('xml/?select=*.xml');

<html>
<head>
    <title>Suspenseful Stories</title>
</head>   

<body>
    <h1>Suspenseful Occurances in our Collection</h1>
    <p>Suspense is a key part of <gs>Ghost Stories</gs> and we have more than you can handle in our collection from different books throughout the Victorian Era.</p>
    
        <table>
            <th>Number</th><tr><th>Suspenseful Paragraph</th><th>Occurrences</th></tr>
            
{
let $doc := doc('../xml/DBest_the_grey_woman.xml')
(:Loads up the XML document:)
let $tone-type := $doc//title/@tone
(:Grabs the type of tone from the title:)
let $suspenseful-paragraphs := 
for $paragraph in $doc//p
where $tone-type = 'suspenseful'
(:Finds paragraphs with a suspenseful tone:)
order by string-length($paragraph) descending
(:Organized the paragraphs from longest to shortest:)
return $paragraph
for $para at $pos in $suspenseful-paragraphs
let $occurrences := string-length($para)
(:This was supposed to use the paragraph length to determine the occurance strength, but I wound up numbering the paragraphs and counting the characters?..:)
return 
    <tr>
        <td>{$pos}</td>
        <td>{$para/string()}</td>
        <td>{$occurrences}</td>
    </tr>
}
        </table>
    </body>
</html>