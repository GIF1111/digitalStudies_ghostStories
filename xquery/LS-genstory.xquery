declare option saxon:output "method=html";
declare option saxon:output "doctype-system=about:legacy-compat";

<html>
  <head>
    <title>Story Titles</title>
    <link type="text/css" href="styleV1.css" rel="stylesheet" />
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
    <!-- -LS This is the menu bar!-->>

    <main>
      <h1>Ghost Stories</h1>
<ul>

        {
          for $doc in collection("..\\xml?select=*.xml")//title
          let $title := normalize-space($doc)
          let $filename := replace(base-uri($doc), '^.*[\\/](.+?)\.xml$', '$1.html')
          order by $title
          return <li><a style="color:blue">{$title}</a></li>

        }
      </ul>
    </main>

    <footer>
      <p>© Ghost Story Project</p>
    </footer>
  </body>
</html>
