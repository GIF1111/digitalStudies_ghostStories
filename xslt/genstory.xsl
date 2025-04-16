<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    exclude-result-prefixes="xs"
    version="3.0">
    
    <xsl:output method="html" indent="yes" encoding="UTF-8" doctype-system="" doctype-public=""/>
    <xsl:mode on-no-match="shallow-copy"/>
    
    <!-- Load all story XML files -->
    <xsl:variable name="files" select="collection('file:../xml/?select=*.xml')"/>
    
    <xsl:template name="xsl:initial-template">
        <xsl:for-each select="$files">
            <xsl:variable name="story" select="/*"/>
            <xsl:variable name="title" select="normalize-space($story/title)"/>
            <xsl:variable name="year" select="normalize-space(($story//year)[1])"/>
            <xsl:variable name="safe-title"
                select="lower-case(translate(replace($title, '[^A-Za-z0-9 ]', ''), ' ', '-'))"/>
            <xsl:variable name="filename" select="concat($safe-title, '.html')"/>
            
            <!-- Optional: Dynamically call XQuery if supported -->
            <!-- Example assumes the timeline is generated externally and saved to includes/ folder -->
            <xsl:variable name="timeline-file" select="concat('../includes/timeline-', $safe-title, '.html')"/>
            
            <xsl:result-document href="{$filename}">
                <html>
                    <head>
                        <title><xsl:value-of select="$title"/></title>
                        <link rel="stylesheet" href="styleV1.css"/>
                    </head>
                    <body>
                        <nav>
                            <a href="index.html">Home</a>
                            <a href="genstory.html">Ghost Stories</a>
                            <a href="timeline.html">Timeline</a>
                            <a href="#">Mystery</a>
                            <a href="about.html">About</a>
                        </nav>
                        
                        <main class="background-container">
                            <!-- Embed unique SVG timeline with highlight -->
                            <xsl:copy-of select="unparsed-text($timeline-file)" disable-output-escaping="yes"/>
                            
                            <h1><xsl:value-of select="$title"/></h1>
                            <xsl:apply-templates select="$story/node()"/>
                        </main>
                        
                        <footer>
                            <p>Ghost Stories Project | Styled with styleV1.css</p>
                        </footer>
                    </body>
                </html>
            </xsl:result-document>
        </xsl:for-each>
    </xsl:template>
    
    <!-- Template for <p> and inline tags -->
    <xsl:template match="p">
        <p>
            <xsl:if test="@tone">
                <span style="font-style: italic;">[Tone: <xsl:value-of select="@tone"/>]</span><br/>
            </xsl:if>
            <xsl:apply-templates/>
        </p>
    </xsl:template>
    
    <xsl:template match="character|place|quote|year">
        <span class="{name()}"><xsl:apply-templates/></span>
    </xsl:template>
    
    <xsl:template match="text()">
        <xsl:value-of select="."/>
    </xsl:template>
</xsl:stylesheet>
