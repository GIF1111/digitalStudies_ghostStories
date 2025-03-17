xquery version "3.1";

let $doc := doc("file:///C:/Users/squat/Documents/GitHubDocs/digitalStudies_ghostStories/xml/DBest_the_grey_woman.xml")
(:displays the xml file. I'm having a hard time shortening this again...:)

for $paragraph in $doc//p,
    $emotion in $paragraph/emotion
(:made a loop that went through all of the paragraph elements for emotions.:)

let $emotion-type := $emotion/@type,
    $paragraph-text := $paragraph/string()
(:pulls out the emotion type and keeps them to use later.:) 
 
where $emotion-type = 'sadness'
(:Lines that have "sadness" are pulled out.:)

order by string-length($paragraph-text) descending
(:I had the paragraphs sorted from longest to shortest because... why not?:)

return
<sad-paragraph>
    <text>{$paragraph-text}</text>
    <emotion type="{$emotion-type}"/>
</sad-paragraph>
(:made a new element with the paragraph's text and "sadness" emotion and as a result, I get the saddest parts of the story! I'm also surprised it worked...:)