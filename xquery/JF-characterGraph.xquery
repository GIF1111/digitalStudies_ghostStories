let $tones := (
    for $doc in collection("../xml/?select=*.xml")
    return $doc//p/@tone/string()