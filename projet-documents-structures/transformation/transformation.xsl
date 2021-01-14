<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:xs="http://www.w3.org/2001/XMLSchema"
	xmlns:meta="urn:oasis:names:tc:opendocument:xmlns:meta:1.0"
    xmlns:office="urn:oasis:names:tc:opendocument:xmlns:office:1.0"
    xmlns:text="urn:oasis:names:tc:opendocument:xmlns:text:1.0"
	exclude-result-prefixes="xs meta office text"
	version="2.0">
<xsl:output method="xml" encoding="UTF-8" indent="yes"/>
<xsl:variable name="xmlpath" select="document('./output/unziped_odt/content.xml')"/>
<xsl:template match="office:document-meta">
	<TEI xmlns="http://www.tei-c.org/ns/1.0">
            <teiHeader>
                <fileDesc>
                    <titleStmt>
                        <title><xsl:value-of select=".//meta:user-defined[./@meta:name='Titre']"/></title>
                        <author><xsl:value-of select=".//meta:user-defined[./@meta:name='Auteur']"/></author>
                        <respStmt>
                            <resp>TEI générée par xslt et bash à partir d’un fichier odt</resp>
                            <name>Martin Digard</name>
                        </respStmt>
                    </titleStmt>
                    <publicationStmt>
                        <publisher></publisher>
                        <pubPlace></pubPlace>
                        <availability><p><xsl:value-of select=".//meta:user-defined[./@meta:name='Licence']"/></p></availability>
                        <date><xsl:value-of select=".//meta:user-defined[./@meta:name='Date de publication']"/></date>
                    </publicationStmt>
                    <sourceDesc>
                        <bibl type="digitalSource">
                            <xsl:value-of select=".//meta:user-defined[./@meta:name='Source']"/>
                            <xsl:value-of select=".//meta:user-defined[./@meta:name='Date de publication']"/>
                        </bibl>
                        <bibl type="firstEdition">
                            <date><xsl:value-of select=".//meta:user-defined[./@meta:name='Date de la source']"/></date>
                        </bibl>
                    </sourceDesc>
                </fileDesc>
                <encodingDesc>
                    <projectDesc>
                        <p><xsl:value-of select=".//meta:user-defined[./@meta:name='Description']"/></p>
                        <p>Date de création : <xsl:value-of select=".//meta:creation-date"/></p>               
                    </projectDesc>
                </encodingDesc>
            </teiHeader>
				<text>
					<front><head><xsl:value-of select="$xmlpath//text:p[@text:style-name='Title']"/></head></front>
                <body>
					<xsl:for-each select="$xmlpath//text:p[@text:style-name='Title']/following-sibling::*">
                        <xsl:choose>
                        <xsl:when test="./@text:outline-level = '1'">
                            <p part="I"><xsl:value-of select="."/></p>
                        </xsl:when>
                        <xsl:when test="./@text:outline-level = '2'">
                            <p part="Y"><xsl:value-of select="."/></p>
                        </xsl:when>
                        <xsl:otherwise>
                            <p><xsl:value-of select="."/></p>
                        </xsl:otherwise>
                        </xsl:choose>   
                    </xsl:for-each>
                </body>
            </text>
				</TEI>
</xsl:template>
</xsl:stylesheet>
