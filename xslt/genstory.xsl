<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    exclude-result-prefixes="xs" version="3.0">
    
    
    <xsl:output method="html" encoding="UTF-8" indent="yes"/>
    
    <!-- Variable to store the collection of XML data -->
    <xsl:variable name="digitalStudies_ghostStoriesProject" select="collection('../xml/?select=*.xml')"/>
    
    
    
    <!-- Main template for the Collection of Stories page -->
    <xsl:template match="/">
        <html>
            <head>
                <title>Collection of Stories</title>
                <link type="text/css" href="styleV1.css" rel="stylesheet"/>
            </head>
            
            <body>
                
                
                <!-- Start main content section -->
                <main>
                    
                    <h1>Collection of Stories</h1>
                    <!-- -LS This is the menu bar!-->
                    <nav>
                        <div class="dropDown">
                            <a href="index.html">Home</a>
                        </div>
                        <div class="dropDown">
                            <a href="genstory.html">Ghost Stories</a>
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
                    <ul>
                        <xsl:apply-templates select="$digitalStudies_ghostStoriesProject//story">
                            
                        </xsl:apply-templates>
                    </ul>
                </main>
                

            </body>
        </html>
    </xsl:template>
    
    <xsl:template match="//story">
        <li>
            <!-- Title and Year in the same line with a space and colon between them -->
            <strong>
                <a href="{translate(descendant::title, ' ', '-')}.html">
                    <xsl:value-of select="descendant::title"/>
                </a>
            </strong>
            <span> </span> <!-- Add colon and space between title and year -->
        </li>
            <xsl:choose>
                <xsl:when test="descendant::year">
                    <xsl:value-of select="descendant::year"/>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:text>(Not Recorded)</xsl:text>
                </xsl:otherwise>
            </xsl:choose>
            
    
        
        <!-- Generate individual story pages -->
        <xsl:call-template name="generate-story-page">
            <xsl:with-param name="title" select="descendant::title"/>
            <xsl:with-param name="year" select="descendant::year"/>
            
            <xsl:with-param name="p" select="descendant::p"/>
   
            <xsl:with-param name="characters" select="descendant::characters/char"/>
        </xsl:call-template>
    </xsl:template>
    
    <!-- Template to generate individual story pages -->
    <xsl:template name="generate-story-page">
        <xsl:param name="title"/>
        <xsl:param name="year"/>
        
        <xsl:param name="p"/>
        
        <xsl:param name="characters"/>
        
        <xsl:result-document href="../docs/{translate($title, ' ', '-')}.html" method="html">
            <html>
                <head>
                    <title>
                        <xsl:value-of select="$title"/>
                    </title>
                    <link type="text/css" href="styleV1.css" rel="stylesheet" />
                </head>
                <body>
                    
                    
                    <!-- Main content section -->
                    <main>
                        <!-- -LS This is the menu bar!-->
                        <nav>
                            <div class="dropDown">
                                <a href="index.html">Home</a>
                            </div>
                            <div class="dropDown">
                                <a href="genstory.html">Ghost Stories</a>
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
                        
                        <h1><xsl:value-of select="$title"/></h1>
                        <h2>
                            <xsl:choose>
                                <xsl:when test="$year">
                                    <xsl:value-of select="$year"/>
                                </xsl:when>
                                <xsl:otherwise>
                                    <xsl:text>(Not Recorded)</xsl:text>
                                </xsl:otherwise>
                            </xsl:choose>
                        </h2>
                        
                       
                       
                        
                        <!-- Back link -->
                        <a href="genstory.html">Back to Stories</a>
                        <hr/>
                    </main>
                    
                
                </body>
            </html></xsl:result-document>
    </xsl:template></xsl:stylesheet>
   

 
