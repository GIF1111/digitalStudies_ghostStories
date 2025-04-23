<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    version="3.0"
    xmlns:xlink="http://www.w3.org/1999/xlink"
    exclude-result-prefixes="#all">
    
    <xsl:output method="html" indent="yes" encoding="UTF-8"/>
    
    <!-- Prevent automatic copying of everything -->
    <xsl:mode on-no-match="shallow-skip"/>
    
    <!-- Match the root story element -->
    <xsl:template match="/story">
        <html>
            <head>
                <title><xsl:value-of select="normalize-space(title)"/></title>
                <link rel="stylesheet" href="styleV1.css"/>
            </head>
            <body>
                <nav>
                    <a href="index.html">Home</a>
                    <a href="tonepage.html">Tone Analysis</a>
                    <a href="character-analysis.html">Character Analysis</a>
                    <a href="about.html">About</a>
                </nav>
                <main class="background-container">
                    <h1><xsl:value-of select="title"/></h1>
                    
                    <!-- Timeline rendered here -->
                    <xsl:apply-templates select="timeline"/>
                    
                    <!-- Story body: chapters and paragraphs -->
                    <xsl:apply-templates select="chapter | p"/>
                </main>
            </body>
        </html>
    </xsl:template>
    
    <!-- Copy inline SVG timeline and wrap in a container -->
    <xsl:template match="timeline">
        <span class="timeline-container">
            <xsl:copy-of select="*"/>
        </span>
    </xsl:template>
    
    <!-- Format paragraphs, show tone if present -->
    <xsl:template match="p">
        <p>
            <xsl:if test="@tone">
                <span style="font-style: italic;">[Tone: <xsl:value-of select="@tone"/>]</span><br/>
            </xsl:if>
            <xsl:apply-templates/>
        </p>
    </xsl:template>
    
    <!-- Format chapters -->
    <xsl:template match="chapter">
        <section class="chapter">
            <h2><xsl:value-of select="@title"/></h2>
            <xsl:apply-templates/>
        </section>
    </xsl:template>
    
    <!-- Inline markup for characters, places, quotes, and years -->
    <xsl:template match="character | place | quote | year">
        <span class="{name()}">
            <xsl:apply-templates/>
        </span>
    </xsl:template>
    
    <!-- Handle text nodes -->
    <xsl:template match="text()">
        <xsl:value-of select="."/>
    </xsl:template>
    
</xsl:stylesheet>
