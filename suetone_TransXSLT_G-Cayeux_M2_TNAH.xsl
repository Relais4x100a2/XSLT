<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:tei="http://www.tei-c.org/ns/1.0"
    xpath-default-namespace="http://www.tei-c.org/ns/1.0" exclude-result-prefixes="xs tei"
    version="2.0">

    <xsl:output method="html" indent="yes" encoding="UTF-8"/>
    <xsl:strip-space elements="*"/>

    <!-- DEFINITION DES VARIABLES A PARTIR DU TEIHEADER -->
    <xsl:variable name="titre_nav">
        <xsl:value-of select="//fileDesc/titleStmt[1]/title[1]/text()"/>
        <xsl:text> - </xsl:text>
        <xsl:value-of select="//fileDesc/titleStmt[1]/title[2]/text()"/>
        <xsl:text> de </xsl:text>
        <xsl:value-of select="//fileDesc/titleStmt[1]/author/persName[1]/text()"/>
    </xsl:variable>
    <xsl:variable name="description">
        <xsl:value-of select="//fileDesc/publicationStmt[1]/p[1]/text()"/>
    </xsl:variable>

    <!-- DEFINITION DES VARIABLES DE NOMS DE FICHIERS DE SORTIE -->
    <xsl:variable name="path_home">
        <xsl:text>home.html</xsl:text>
    </xsl:variable>
    <xsl:variable name="path_edition">
        <xsl:text>edition.html</xsl:text>
    </xsl:variable>
    <xsl:variable name="path_index_pers">
        <xsl:text>index_pers.html</xsl:text>
    </xsl:variable>
    <xsl:variable name="path_index_lieux">
        <xsl:text>index_lieux.html</xsl:text>
    </xsl:variable>
    <xsl:variable name="path_index_temoins">
        <xsl:text>index_temoins.html</xsl:text>
    </xsl:variable>
    <xsl:variable name="tei">
        <xsl:text>suetone_G-Cayeux_M2_TNAH.xml</xsl:text>
    </xsl:variable>
    <xsl:variable name="odd">
        <xsl:text>suetone_G-Cayeux_M2_TNAH_ODD.html</xsl:text>
    </xsl:variable>

    <!-- DEFINITION DE LA VARIABLE POUR LE HEAD HTML -->
    <xsl:variable name="head">
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
        <meta name="description" content="{$description}"/>
        <meta name="keywords" content="Suetone, Vie des douze Césars, TEI, XSLT"/>
        <meta name="author" content="Guillaume Cayeux"/>
        <style>
            /* Paramètrage CSS spécifique pour la balise tooltip */
            .mytooltip {
                position: relative;
                display: inline-block;
                color: red;
            }
            
            /* Tooltip text */
            .mytooltip .mytooltiptext {
                visibility: hidden;
                width: 400px;
                top: 100%;
                left: 60%;
                margin-left: -240px;
                background-color: #FFDADA;
                text-align: left;
                border-radius: 0% 0% 10% 10%;
                position: absolute;
                placement: bottom;
                z-index: 1;
                color: black;
            }
            
            .mytooltip:hover .mytooltiptext {
                visibility: visible;
            }</style>
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"/>
        <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"/>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta3/dist/css/bootstrap.min.css"
            rel="stylesheet"
            integrity="sha384-eOJMYsd53ii+scO/bJGFsiCZc+5NDVN2yr8+0RDqr0Ql0h+rP48ckxlpbzKgwra6"
            crossorigin="anonymous"/>
    </xsl:variable>

    <!-- DEFINITION DE LA VARIABLE POUR LA BARRE DE NAVIGATION -->
    <xsl:variable name="nav_bar">
        <nav class="navbar navbar-expand-md navbar-light justify-content-between"
            style="background-color: #FFDADA;">
            <a class="navbar-brand" style="padding-left: 30px" href="{$path_home}">
                <xsl:value-of select="$titre_nav"/>
            </a>

            <ul class="navbar-nav mr-auto">
                <li class="nav-item">
                    <a class="nav-link" href="{$path_edition}">Éditions numériques</a>
                </li>

                <li class="nav-item">
                    <a class="nav-link" href="{$path_index_pers}">Personnages</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="{$path_index_lieux}">Lieux</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="{$path_index_temoins}">Témoins</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="sources/{$tei}" target="_blank">Encodage TEI</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="sources/{$odd}" target="_blank">ODD au format HTML</a>
                </li>


            </ul>

        </nav>
    </xsl:variable>

    <!-- DEFINITION DE LA VARIABLE POUR LE FOOTER -->
    <xsl:variable name="footer">
        <footer>
            <hr class="style-one"/>
            <div class="container">
                <div class="text-center justify-content-center">
                    <p>Guillaume Cayeux - Site développé dans le cadre des enseignements du <a
                            href="http://www.chartes.psl.eu/fr/cursus/master-technologies-numeriques-appliquees-histoire"
                            target="_blank">Master 2 TNAH</a></p>
                    <a href="http://www.chartes.psl.eu/" target="_blank">
                        <img src="./img/logo_enc.png" alt="Logo de l'École des chartes"
                            class="d-inline-block align-text-top rounded float-right" width="225"
                            height="60"/>
                    </a>
                </div>
            </div>
        </footer>
    </xsl:variable>

    <!-- TEMPLATE PAGES HTML -->
    <xsl:template match="/">
        <!-- PAGE ACCUEIL -->
        <xsl:result-document href="html/{$path_home}" method="html" indent="yes">
            <html>
                <head>
                    <xsl:copy-of select="$head"/>
                    <title>Accueil</title>
                </head>
                <body>
                    <xsl:copy-of select="$nav_bar"/>
                    <div class="container p-4">
                        <div class="row">
                            <div class="col-md-6">
                                <h2>Accueil</h2>
                                <div align="justify">
                                    <p>Ce site édite numériquement un extrait du livre <xsl:value-of
                                            select="$titre_nav"/>.</p>
                                    <p>Compte tenu du nombre important de témoins, nous avons fait
                                        le choix de mettre en regard une édition enrichie à une
                                        édition critique reprenant l'ensemble des témoins.</p>
                                    <p>Afin d'en savoir plus sur l'encodage et cette édition d'une
                                        manière générale, n'hésitez pas à cliquer sur les onglets <a
                                            href="{$tei}" target="_blank">encodage TEI</a> et <a href="{$odd}" target="_blank">ODD
                                            au format HTML.</a></p>
                                </div>
                            </div>
                            <div class="col-md-6">
                                <img src="img/Suetonius.jpg" class="rounded mx-auto d-block"
                                    alt="Suétone" width="280" height="500"/>
                            </div>
                        </div>
                    </div>

                </body>
                <xsl:copy-of select="$footer"/>

            </html>
        </xsl:result-document>

        <!-- PAGE TEMOINS -->
        <xsl:result-document href="html/{$path_index_temoins}" method="html" indent="yes">

            <html>
                <head>
                    <xsl:copy-of select="$head"/>

                    <title>Liste des témoins</title>

                </head>
                <body>
                    <xsl:copy-of select="$nav_bar"/>
                    <h1 style="text-align: center" class="mt-4">Liste des témoins</h1>

                    <div class="container p-4">
                        <div class="row">
                            <ul>
                                <xsl:call-template name="wit_liste"/>
                            </ul>
                        </div>
                    </div>
                </body>
                <footer>
                    <xsl:copy-of select="$footer"/>
                </footer>
            </html>
        </xsl:result-document>



        <!-- PAGE ÉDITION -->
        <xsl:result-document href="html/{$path_edition}" method="html" indent="yes">
            <html>
                <head>
                    <xsl:copy-of select="$head"/>
                    <title>Éditions numériques</title>
                </head>
                <body>
                    <xsl:copy-of select="$nav_bar"/>
                    <h1 style="text-align: center" class="mt-4">Éditions numériques</h1>
                    <img src="./img/cesar.jpg" class="rounded mx-auto d-block" alt="Jules César"
                        width="200" height="234"/>
                    <div class="container p-4">
                        <div class="row">

                            <div class="col-md-6">
                                <h2 style="text-align: center" class="mt-4">Édition enrichie</h2>
                                <h3 style="text-align:center" class="mt-4">
                                    <xsl:value-of select="descendant::div[1]/head[1]/text()"/>
                                    <xsl:text> - </xsl:text>
                                    <xsl:value-of select="descendant::div[1]/head[2]/text()"/>
                                </h3>
                                <xsl:apply-templates select="descendant::body/div/div" mode="orig"/>
                            </div>
                            <div class="col-md-6">
                                <h2 style="text-align: center" class="mt-4">Édition critique</h2>
                                <h3 style="text-align:center" class="mt-4">
                                    <xsl:value-of select="descendant::div[1]/head[1]/text()"/>
                                    <xsl:text> - </xsl:text>
                                    <xsl:value-of select="descendant::div[1]/head[2]/text()"/>
                                </h3>
                                <xsl:apply-templates select="descendant::body/div/div" mode="critiq"
                                />
                            </div>
                        </div>
                    </div>
                </body>
                <xsl:copy-of select="$footer"/>
            </html>

        </xsl:result-document>



        <!-- PAGE PERSONNAGES -->
        <xsl:result-document href="html/{$path_index_pers}" method="html" indent="yes">
            <html>
                <head>
                    <xsl:copy-of select="$head"/>
                    <title>Index des personnages</title>
                </head>
                <body>
                    <xsl:copy-of select="$nav_bar"/>
                    <div class="container p-4">
                        <h2>Les personnages</h2>
                        <xsl:call-template name="perso_tableau"/>
                    </div>
                </body>
                <footer>
                    <xsl:copy-of select="$footer"/>
                </footer>
            </html>
        </xsl:result-document>


        <!-- PAGE LIEUX -->
        <xsl:result-document href="html/{$path_index_lieux}" method="html" indent="yes">
            <html>
                <head>
                    <xsl:copy-of select="$head"/>
                    <title>Index des lieux</title>
                </head>
                <body>
                    <xsl:copy-of select="$nav_bar"/>
                    <div class="container p-4">
                        <h2>Les lieux</h2>
                        <xsl:call-template name="lieux_tableau"/>
                    </div>
                </body>
                <footer>
                    <xsl:copy-of select="$footer"/>
                </footer>
            </html>
        </xsl:result-document>
    </xsl:template>



    <!-- TEMPLATE SERVANT A INSERER LES EDITIONS NUMERIQUES -->
    <xsl:template match="//div/div" mode="#all">
        <xsl:element name="h4">
            <xsl:attribute name="style">
                <xsl:text>text-align:center</xsl:text>
            </xsl:attribute>
            <xsl:attribute name="class">
                <xsl:text>mt-4 mb-4</xsl:text>
            </xsl:attribute> Chapitre [<xsl:value-of select="@n"/>]</xsl:element>
        <xsl:element name="p">
            <xsl:attribute name="style">
                <xsl:text>line-height: 2; text-align: justify</xsl:text>
            </xsl:attribute>
            <xsl:for-each select="p[@n]"> [<xsl:value-of select="@n"/>] - <xsl:apply-templates
                    mode="#current"/>
                <br/>
            </xsl:for-each>
        </xsl:element>
    </xsl:template>

    <xsl:template match="app" mode="orig">
        <xsl:value-of select="./lem//text()"/>
    </xsl:template>

    <xsl:template match="app" mode="critiq">
        <xsl:element name="span">
            <xsl:attribute name="class">
                <xsl:text>mytooltip</xsl:text>
            </xsl:attribute>
            <xsl:value-of select="./lem//text()"/>
            <xsl:element name="span">
                <xsl:attribute name="class">
                    <xsl:text>mytooltiptext</xsl:text>
                </xsl:attribute>
                <table class="table table-responsive-sm">
                    <xsl:for-each select="./rdg">
                        <tr class="table-info">
                            <td>Témoin(s) :</td>
                            <td>
                                <xsl:value-of select="attribute(wit)"/>
                            </td>
                        </tr>
                        <xsl:if test="attribute(type)">
                            <tr>
                                <td>Type : </td>
                                <td>
                                    <xsl:value-of select="attribute(type)"/>
                                </td>
                            </tr>
                        </xsl:if>
                        <tr>
                            <td>Variante :</td>
                            <td>
                                <em>
                                    <strong>
                                        <xsl:value-of select="text()"/>
                                    </strong>
                                </em>
                            </td>
                        </tr>
                        <xsl:if test="note/text()">
                            <tr>
                                <td>Note :</td>
                                <td>
                                    <xsl:value-of select="note/text()"/>
                                </td>
                            </tr>
                        </xsl:if>
                    </xsl:for-each>
                </table>
            </xsl:element>
        </xsl:element>
    </xsl:template>





    <!-- TEMPLATE SERVANT A INSERER L'INDEX DES PERSONNAGES A PARTIR DES INFOS DU TEIHEADER -->
    <xsl:template name="perso_tableau" match="TEI//listPerson/person">
        <xsl:for-each select="descendant::person">
            <!-- Chaque personnage a son tableau et son id -->
            <table id="{@xml:id}">
                <tbody>
                    <thead class="head">
                        <tr>
                            <td>

                                <strong>
                                    <xsl:value-of select="persName[1]/text()"/>
                                </strong>

                            </td>
                        </tr>
                    </thead>

                    <tr>
                        <td align="justify">
                            <xsl:value-of select="descendant::note/text()"/>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <a href="{descendant::note/ref/@target}">
                                <xsl:value-of select="descendant::note/ref/text()"/>
                            </a>
                        </td>
                    </tr>

                    <xsl:if test="descendant::idno//text()">
                        <tr>
                            <td>
                                <a href="{descendant::idno/text()}">Notice d'autorité</a>
                            </td>
                        </tr>
                    </xsl:if>
                </tbody>
            </table>
            <br/>
        </xsl:for-each>
    </xsl:template>

    <!-- TEMPLATE SERVANT A INSERER UNE ANCRE PERSONNE RENVOYANT VERS L'ENTREE CORRESPONDANTE DANS L'INDEX DES PERSONNAGES -->
    <xsl:template name="persname" match="TEI//body//p//persName" mode="orig">
        <xsl:variable name="nom_pers">
            <xsl:value-of select="./@ref"/>
        </xsl:variable>
        <xsl:element name="a">
            <xsl:attribute name="href">
                <xsl:value-of select="$path_index_pers"/>
                <xsl:value-of select="@ref"/>
            </xsl:attribute>
            <xsl:attribute name="id">
                <xsl:value-of select="replace(@ref, '#', '')"/>
            </xsl:attribute>
            <xsl:attribute name="class">
                <xsl:text>perso</xsl:text>
            </xsl:attribute>
            <xsl:attribute name="target">_blank</xsl:attribute>
            <xsl:value-of select="text() | app/lem/text()"/>
        </xsl:element>
    </xsl:template>


    <!-- TEMPLATE SERVANT A INSERER UNE ANCRE LIEU RENVOYANT VERS L'ENTREE CORRESPONDANTE DANS L'INDEX DES LIEUX-->
    <xsl:template name="placename" match="TEI//body//p//placeName" mode="orig">
        <xsl:variable name="nom_lieu">
            <xsl:value-of select="./@ref"/>
        </xsl:variable>
        <xsl:element name="a">
            <xsl:attribute name="href">
                <xsl:value-of select="$path_index_lieux"/>
                <xsl:value-of select="@ref"/>
            </xsl:attribute>
            <xsl:attribute name="id">
                <xsl:value-of select="replace(@ref, '#', '')"/>
            </xsl:attribute>
            <xsl:attribute name="class">
                <xsl:text>lieux</xsl:text>
            </xsl:attribute>
            <xsl:attribute name="target">_blank</xsl:attribute>
            <xsl:value-of select="text() | app/lem/text()"/>
        </xsl:element>
    </xsl:template>


    <!-- TEMPLATE SERVANT A INSERER L'INDEX DES LIEUX A PARTIR DES INFOS DU TEIHEADER -->
    <xsl:template name="lieux_tableau" match="TEI//listPlace">
        <xsl:for-each select="descendant::place">
            <table id="{@xml:id}">
                <tbody>
                    <thead>
                        <tr>
                            <td>
                                <strong>
                                    <xsl:value-of select="descendant::placeName/text()"/>
                                </strong>
                            </td>
                        </tr>
                    </thead>
                    <tr>
                        <td align="justify">
                            <xsl:value-of select="descendant::note/text()"/>
                        </td>
                    </tr>
                    <xsl:variable name="loc">
                        <xsl:value-of select="concat('https://www.google.com/maps/place/', @xml:id)"
                        />
                    </xsl:variable>
                    <!-- Les id des lieux ont été "actualisés" afin de permettre leur visualisation sur Google Maps -->
                    <tr>
                        <td>
                            <a href="{$loc}" target="_blank">Voir carte</a>
                        </td>
                    </tr>
                </tbody>
            </table>
            <br/>
        </xsl:for-each>
    </xsl:template>

    <!-- TEMPLATE SERVANT A INSERER LA LISTE DES TEMOINS A PARTIR DES INFOS DU TEIHEADER -->
    <xsl:template name="wit_liste">
        <xsl:for-each select="//witness/@xml:id">
            <ul>
                <span style="font-weight:bold; font-size:18px;">
                    <xsl:value-of select="."/>
                </span>
                <xsl:value-of
                    select="
                        ancestor::witness/text()
                        | ancestor::witness/persName/text()
                        | ancestor::witness/date/text()"/>
                <xsl:text>.</xsl:text>
            </ul>
        </xsl:for-each>
    </xsl:template>



</xsl:stylesheet>
