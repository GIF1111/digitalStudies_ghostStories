xquery version "3.1";

declare namespace svg = "http://www.w3.org/2000/svg";

(: Declare global variables :)
declare variable $docs := collection("..\xml?select=*.xml");
declare variable $years := distinct-values(for $doc in $docs return $doc//year/xs:integer(.));
declare variable $min-year := min($years);
declare variable $max-year := max($years);
declare variable $width := 800;
declare variable $height := 100;
declare variable $margin := 50;
declare variable $scale := ($width - 2 * $margin) div ($max-year - $min-year);

(: Helper to position x from year :)
declare function local:x($y as xs:integer) as xs:double {
  $margin + ($y - $min-year) * $scale
};

(: Full HTML Output :)
<html>
  <head>
    <title>Story Titles</title>
    <link type="text/css" href="styleV1.css" rel="stylesheet"/>
  </head>
  <body>
    <!-- -LS This is the menu bar!-->
    <nav>
      <div class="dropDown">
        <a href="index.html">Home</a>
      </div>
      <div class="dropDown">
        <a href="ghoststory.html">Ghost Stories</a>
      </div>
      <div class="dropDown">
        <a href="timeline.html">Timeline</a>
      </div>
      <div class="dropDown">
        <a href="">INSERT</a>
      </div>
      <div class="dropDown">
        <a href="about.html">About</a>
        <div class="menu">
          <a href="">Team</a>
          <div class="section-divider"></div>
        </div>
      </div>
    </nav>
    <!-- -LS This is the menu bar!-->
<main>
    <div id="timeline">
      <svg xmlns="http://www.w3.org/2000/svg" width="{$width}" height="{$height}">
        <!-- Title -->
        <text x="{$width div 2}" y="30" font-size="20" font-weight="bold" text-anchor="middle">Ghost Story Years</text>
        <!-- Horizontal line -->
        <line x1="{$margin}" y1="{$height div 2}" x2="{$width - $margin}" y2="{$height div 2}" stroke="black" stroke-width="2"/>
        
        {
          for $y in $years
          let $x := local:x($y)
          order by $y
          return (
            <circle cx="{$x}" cy="{$height div 2}" r="5" fill="blue"/>,
            <text x="{$x}" y="{$height div 2 + 20}" font-size="12" text-anchor="middle">{$y}</text>
          )
        }
      </svg>
    </div>
    </main>
    <footer>
      <p>© Ghost Story Project</p>
    </footer>
  </body>
</html>
