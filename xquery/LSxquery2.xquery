xquery version "3.1";


(: Get all speech elements :)
let $speeches := //p

(: Get individual speakers :)
let $distinct-speakers := distinct-values($speeches/char)

(: Process each speaker + count :)
for $speaker in $distinct-speakers
let $speech-count := count($speeches[char = $speaker])

(: Only include speakers who speak greater than or equal to 1  :)
where $speech-count >= 1

(: Sort speakers by frequency :)
order by $speech-count descending

(: Output XML :)
return <speaker name="{$speaker}" speech-count="{$speech-count}"/>
