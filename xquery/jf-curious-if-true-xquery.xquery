xquery version '3.1';
declare option saxon:output 'method=text';

(: be for it gets messy I am trying to loop throigh the story in a single xml file to get a tone specific from a paragraph that containt it:)


(:doc used for single file use of xquery:)
for $p in doc("curious-if-true-xml-copy/curious_if_true.xml")//p
    let $tone := $p/tone/@type
    where $tone = "suspenseful"
    order by $p/@n
    return concat("paragraph number ", $p/@n, ": ", $p, "&#10;&#10;")
(: so I thouht order by $p/@n was supposed to be asscending order
maybe i am wrong but dont know how to make the output look super pretty:)
    

