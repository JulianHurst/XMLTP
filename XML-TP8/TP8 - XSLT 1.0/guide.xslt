<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:a="http://www.univ-amu.fr/XML/guide" xmlns:com="http://www.univ-amu.fr/XML/commun">
	<xsl:output method="html" version="5.0" encoding="UTF-8" indent="yes"/>
	<xsl:template match="/">
		<html>
			<head>
				<title>
					<xsl:value-of select="//a:titre"/>
				</title>
			</head>
			<body>
				<center><h1><xsl:value-of select="//a:titre"/></h1></center>
				<h2>Auteurs :</h2>
				<xsl:apply-templates select="a:guide/a:auteur"/>
				<h2>Editeur :</h2>
				<xsl:value-of select="//a:éditeur"/>
				<h2>Année</h2>
				<xsl:value-of select="//a:année"/>
				<h2>Vallons :</h2>
				<xsl:apply-templates select="a:guide/a:vallon"/>
			</body>		
		</html>
	</xsl:template>
	
	<xsl:template match="a:auteur">
		<xsl:value-of select="com:civilité"/><xsl:text> </xsl:text>
		<xsl:value-of select="com:prénomUsuel"/><xsl:text> </xsl:text>
		<xsl:value-of select="com:nom"/>
		<br/>
	</xsl:template>
	
	<xsl:template match="a:vallon">
		<h3><xsl:value-of select="a:nom"/></h3>
		<b>Introduction :</b><br/><br/>
		<xsl:apply-templates select="a:introduction"/>
		<b>Itinéraires :</b><br/><br/>
		<xsl:for-each select="a:itinéraire">
			<i>
				<xsl:element name="a">
					<xsl:attribute name="name">
						<xsl:value-of select="@numéro"/>
					</xsl:attribute>
					<xsl:value-of select="a:nom"/><xsl:text> : </xsl:text>						
				</xsl:element>
			</i><br/><br/>
			<xsl:text>Altitude : </xsl:text>
			<xsl:value-of select="a:altitude"/><br/>
			<xsl:text>Cotation : </xsl:text>
			<xsl:value-of select="a:cotation"/><br/><br/>
			<xsl:for-each select="a:paragraphe">
				<xsl:value-of select="text()"/><br/><br/>
				<xsl:variable name="cibler">
					<xsl:value-of select="a:renvoi/@cible"/>
				</xsl:variable>
				<xsl:text>Renvoi : </xsl:text>
				<xsl:element name="a">
					<xsl:attribute name="href">					
						<xsl:text>#</xsl:text><xsl:value-of select="$cibler"/>
					</xsl:attribute>		
						<xsl:for-each select="//a:itinéraire">
							<xsl:if test="$cibler=@numéro">
								<xsl:value-of select="a:nom"/>
							</xsl:if>					
						</xsl:for-each>	
						<xsl:for-each select="//a:note">
							<xsl:if test="$cibler=@ident">
								<xsl:value-of select="$cibler"/>
							</xsl:if>					
						</xsl:for-each>		
				</xsl:element>
				<br/>
				<br/>		
				<xsl:text>Notes : </xsl:text><br/>
				<xsl:element name="a">
					<xsl:attribute name="name">
						<xsl:value-of select="a:note/@ident"/>
					</xsl:attribute>
					<xsl:value-of select="a:note/@ident"/><br/>
					<xsl:value-of select="a:note"/>
				</xsl:element>					
			</xsl:for-each>
		</xsl:for-each>
		<br/>
		<br/>		
	</xsl:template>
	
	<xsl:template match="a:introduction">
		<xsl:for-each select="a:paragraphe">
				<xsl:text>Renvoi : </xsl:text>
				<xsl:variable name="cibler">
					<xsl:value-of select="a:renvoi/@cible"/>
				</xsl:variable>
				<xsl:element name="a">
					<xsl:attribute name="href">										
							<xsl:text>#</xsl:text><xsl:value-of select="$cibler"/>								
					</xsl:attribute>		
					<xsl:for-each select="//a:itinéraire">
						<xsl:if test="$cibler=@numéro">
							<xsl:value-of select="a:nom"/>
						</xsl:if>					
					</xsl:for-each>		
					<xsl:for-each select="//a:note">
						<xsl:if test="$cibler=@ident">
							<xsl:value-of select="$cibler"/>
						</xsl:if>					
					</xsl:for-each>				
				</xsl:element>
				<br/>
				<br/>
				<xsl:value-of select="text()"/>			
				<br/>
				<br/>
				<xsl:text>Notes : </xsl:text><br/>
				<xsl:element name="a">
					<xsl:attribute name="name">
						<xsl:value-of select="a:note/@ident"/>
					</xsl:attribute>
					<xsl:value-of select="a:note"/>
				</xsl:element>			
				<br/>
				<br/>
			</xsl:for-each>
	</xsl:template>
</xsl:stylesheet>
