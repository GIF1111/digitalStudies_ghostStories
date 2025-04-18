declare option saxon:output "method=html";
declare option saxon:output "doctype-system=about:legacy-compat";

<html>

   <head>
      <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
      <title>Collection of Stories</title>
      
   <html lang="en">
      <head>
         <meta charset="UTF-8">
         <meta name="viewport" content="width=device-width, initial-scale=1.0">
         <title>Ghost Stories | Home</title>
         <link rel="stylesheet" href="styleV1.css">
         <style>
        body, html {
            margin: 0;
            padding: 0;
            font-family: 'Georgia', serif;
            color: #f5f5f5;
        }

        nav {
            display: flex;
            justify-content: space-around;
            background: #000;
            padding: 1rem;
        }

        nav a {
            color: #eee;
            text-decoration: none;
            font-weight: bold;
        }

        nav a:hover {
            color: red;
        }

        .title {
            background-image: url('../images/gothic-7180565.jpg');
            background-size: cover;
            background-position: center;
            height: 100vh;
            display: flex;
            flex-direction: column;
            justify-content: center;
            align-items: center;
            text-align: center;
        }

        .title h1 {
            font-size: 3rem;
            color: white;
            text-shadow: 2px 2px 8px rgba(0, 0, 0, 0.8);
        }

        .subtitle {
            color: red;
            font-size: 1.5rem;
            margin-top: 0.5rem;
        }

        main {
            background-color: #111;
            padding: 2rem;
        }

        .intro p {
            font-size: 1.2rem;
            margin: 0.5rem 0;
        }

        .stories h2 {
            text-align: center;
            margin-bottom: 1rem;
        }

        .story-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
            gap: 1.5rem;
        }

        .story-card {
            background: #222;
            padding: 1rem;
            border-radius: 8px;
        }

        .story-card h3 {
            color: #fff;
            font-size: 1.3rem;
        }

        .story-card p {
            color: #ccc;
        }

        .image-section {
            background: #1a1a1a;
            padding: 2rem;
            text-align: center;
        }

        .image-box {
            background-image: url('../images/london-6717244.jpg');
            background-size: cover;
            background-position: center;
            padding: 4rem 2rem;
            color: white;
            border-radius: 10px;
        }

        footer {
            text-align: center;
            background: #000;
            padding: 1rem;
            color: red;
            font-size: 0.9rem;
        }
    </style>
      </head>
      <body>
         <nav>
            <a href="index.html">Home</a>
            <a href="genstory.html">Ghost Stories</a>
            <a href="timeline.html">Timeline</a>
            <a href="#">Mystery</a>
            <a href="about.html">About</a>
         </nav>
         
         <header class="title">
            <h1>Welcome to the Ghost Stories Website</h1>
            <p class="subtitle">Real or fiction? You decide...</p>
         </header>
         
         <main>
            <section class="intro">
               <h2>What You'll Find:</h2>
               <p>Classic Gothic Tales</p>
               <p>Historical Timelines of the Authors</p>
               <p>Character Insights & Lore</p>
               <p>Visual & Immersive Story Experiences</p>
            </section>
            
            <section class="stories">
               <h2>Featured Ghost Stories</h2>
               <div class="story-grid">
                  <div class="story-card">
                     <h3><a href="CURIOUS,-IF-TRUE.html">Curious If True</a></h3>
                     <p>A chilling narrative that blurs dreams and death...</p>
                  </div>
                  <div class="story-card">
                     <h3><a href="LOIS-THE-WITCH-.html">Lois the Witch</a></h3>
                     <p>Salem's secrets come to life in this haunting tale.</p>
                  </div>
                  <div class="story-card">
                     <h3><a href="THE-GREY-WOMAN.html">The Grey Woman</a></h3>
                     <p>A dark escape from terror and oppression.</p>
                  </div>
                                    <div class="story-card">
                     <h3><a href="THE-OLD-NURSE%27S-STORY.html">The Old Nurse’s</a> Story</h3>
                     <p>Tragedy and echoes from the past haunt a quiet estate.</p>
                  </div>
                  <div class="story-card">
                     <h3><a href="THE-OPEN-DOOR.html"> The Open Door</a></h3>
                     <p>What lies beyond the door that never stays shut?</p>
                  </div>
                  <div class="story-card">
                     <h3><a href="THE-POOR-CLARE.html">The Poor Claire</a></h3>
                     <p>A ghostly tale of family, guilt, and redemption.</p>
                  </div>
                  <div class="story-card">
                     <h3><a href="THE-PORTRAIT.html">The Portrait</a></h3>
                     <p>Some paintings hold more than just memories...</p>
                  </div>
               </div>
            </section>
            
            <section class="image-section">
               <div class="image-box">
                  <h2>Ghostly Visuals</h2>
                  <p>Click through to explore more haunted facts and lore.</p>
               </div>
            </section>
         
        
       
        
      </main>
   </body>
   <footer>
      <p >This work is marked with <a href="https://creativecommons.org/publicdomain/zero/1.0/?ref=chooser-v1" target="_blank" rel="license noopener noreferrer" style="display:inline-block;">CC0 1.0<img style="height:22px!important;margin-left:3px;vertical-align:text-bottom;" src="https://mirrors.creativecommons.org/presskit/icons/cc.svg?ref=chooser-v1" alt=""><img style="height:22px!important;margin-left:3px;vertical-align:text-bottom;" src="https://mirrors.creativecommons.org/presskit/icons/zero.svg?ref=chooser-v1" alt=""></a></p> 
   </footer>
</html>

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
