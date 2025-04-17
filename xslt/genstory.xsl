<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    version="3.0">
    
    <xsl:output method="html" indent="yes" encoding="UTF-8"/>
    <xsl:mode on-no-match="shallow-copy"/>
    
    <!-- Template that matches the root node of the single XML file -->
    <xsl:template match="/">
        
        <html>
            <head>
                <title><xsl:value-of select="normalize-space(/story/title)"/></title>
                <link rel="stylesheet" href="styleV1.css"/>
            </head>
            <body>
                <nav><a href="index.html">Home</a><a href="tonepage.html">Tone Analysis</a><a href="#">Mystery</a><a href="about.html">About</a></nav>
                <main class="background-container">
                    <h1><xsl:value-of select="/story/title"/></h1>
                    <xsl:apply-templates/>
                </main>
                
            </body>
        </html>
        
    </xsl:template>
    
    <!-- Paragraph template -->
    <xsl:template match="p">
        <p>
            <xsl:if test="@tone">
                <span style="font-style: italic;">[Tone: <xsl:value-of select="@tone"/>]</span><br/>
            </xsl:if>
            <xsl:apply-templates/>
        </p>
    </xsl:template>
    
    <!-- Chapter template -->
    <xsl:template match="chapter">
        <section class="chapter">
            <h2><xsl:value-of select="@title"/></h2>
            <xsl:apply-templates/>
        </section>
    </xsl:template>
    
    <!-- Inline tags -->
    <xsl:template match="character|place|quote|year">
        <span class="{name()}"><xsl:apply-templates/></span>
    </xsl:template>
    
    <!-- Basic text -->
    <xsl:template match="text()">
        <xsl:value-of select="."/>
    </xsl:template>
    
</xsl:stylesheet>
