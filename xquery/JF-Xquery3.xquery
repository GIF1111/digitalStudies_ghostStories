xquery version '3.1';

declare option saxon:output 'method=html';

(:this gets the string verison's of the titles in each xml story
    My idea for this is to now go through and count how many times a person comes up in the story, and rank them for each story and see who comes up the most frequent.
:)

(: for sum reasaon I keep gettign an error saying something about it being numarical for one of the story's but it still runs I thoguht that /text() would fix it but it doesnt, If someone could help me with this that would be cool:)

let $titles :=
    for $doc in collection("../xml")
    let $title := $doc//title/text()
    return <li>{$title}</li>

return
<html>
    <head>
        <title>Files Titles</title>
    </head>
    <body>
        <h1>List of Titles</h1>
        <ul>
            {$titles}
        </ul>
    </body>
</html>


