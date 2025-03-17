xquery version "3.1";


(: Load all XML files from the XML folder :)
let $docs := collection("..\xml")

(: Extract all speech elements from all XML documents :)
let $speeches := $docs//p

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
(: this works when i do it only on lois the witch, but when I try it as a collection of files I get this error System ID: C:\Users\lston\Desktop\digitalhuman\github\digitalStudies_ghostStoriesProject\xquery\LSxquery2.xquery
Severity: fatal
Problem ID: XPTY0019
Description: The required item type of the first operand of '/' is node(); the supplied value "XML markup: Alan - ... iel - The Grey Woman" is an atomic value. Found while atomizing the first argument of fn:distinct-values()
Start location: 8:19
URL: http://www.w3.org/TR/xpath20/#ERRXPTY0019
:)