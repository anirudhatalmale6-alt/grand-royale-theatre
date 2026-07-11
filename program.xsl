<?xml version="1.0" encoding="UTF-8"?>

<!-- =====================================================================
     program.xsl
     XSL stylesheet that transforms program.xml into an HTML page.
     The browser applies this automatically because program.xml contains
     the <?xml-stylesheet ... ?> processing instruction.
     ===================================================================== -->

<xsl:stylesheet version="1.0"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

    <xsl:output method="html" indent="yes" encoding="UTF-8"/>

    <!-- ============ Template for the whole document ============ -->
    <xsl:template match="/">
        <html lang="en">
            <head>
                <meta charset="utf-8"/>
                <title>The Grand Royale Theatre &#8211; Program</title>
                <!-- the very same CSS file the HTML page uses -->
                <link rel="stylesheet" type="text/css" href="style.css"/>
            </head>
            <body>

                <header>
                    <h1>The Grand Royale Theatre</h1>
                    <p class="tagline">Live drama, comedy and music since 1897</p>
                </header>

                <nav>
                    <ul>
                        <li><a href="index.html">Home</a></li>
                        <li><a class="current" href="program.xml">Program</a></li>
                    </ul>
                </nav>

                <main>
                    <section>
                        <h2>
                            <xsl:value-of select="program/season"/>
                            <xsl:text> </xsl:text>
                            <xsl:value-of select="program/@year"/>
                        </h2>

                        <p>
                            The full program is stored in an XML file
                            (<em>program.xml</em>), validated by a DTD
                            (<em>program.dtd</em>) and transformed into the table
                            below by an XSL stylesheet (<em>program.xsl</em>).
                            To book, call the box office or visit us in person &#8211;
                            see the <a href="index.html">main page</a> for our
                            address and opening times.
                        </p>

                        <table>
                            <caption>
                                <xsl:value-of select="count(program/show)"/>
                                <xsl:text> productions this season</xsl:text>
                            </caption>
                            <thead>
                                <tr>
                                    <th>Date</th>
                                    <th>Time</th>
                                    <th>Production</th>
                                    <th>Director &amp; Cast</th>
                                    <th>Stage</th>
                                    <th>Runs</th>
                                    <th>Ticket</th>
                                </tr>
                            </thead>
                            <tbody>
                                <!-- one table row per <show> element -->
                                <xsl:apply-templates select="program/show"/>
                            </tbody>
                        </table>

                        <p class="note">
                            Concession prices apply to students, seniors and
                            groups of ten or more. All prices in pounds sterling
                            (GBP).
                        </p>
                    </section>
                </main>

                <footer>
                    <p>
                        &#169; 2026 The Grand Royale Theatre &#160;|&#160;
                        <a href="index.html">Back to the Home page</a>
                    </p>
                </footer>

            </body>
        </html>
    </xsl:template>

    <!-- ============ Template for a single <show> ============ -->
    <xsl:template match="show">
        <tr>
            <td><xsl:value-of select="date"/></td>
            <td><xsl:value-of select="time"/></td>

            <td>
                <strong><xsl:value-of select="title"/></strong>
                <xsl:text> </xsl:text>
                <span class="genre"><xsl:value-of select="@genre"/></span>
                <br/>
                <span class="note"><xsl:value-of select="description"/></span>
            </td>

            <td>
                <em>Directed by <xsl:value-of select="director"/></em>
                <!-- the cast list is optional in the DTD, so test for it -->
                <xsl:if test="cast">
                    <ul>
                        <xsl:for-each select="cast/actor">
                            <li>
                                <xsl:value-of select="."/>
                                <xsl:if test="@role">
                                    <xsl:text> (</xsl:text>
                                    <xsl:value-of select="@role"/>
                                    <xsl:text>)</xsl:text>
                                </xsl:if>
                            </li>
                        </xsl:for-each>
                    </ul>
                </xsl:if>
            </td>

            <td><xsl:value-of select="@stage"/></td>
            <td><xsl:value-of select="duration"/></td>

            <td class="price">
                <xsl:text>&#163;</xsl:text>
                <xsl:value-of select="price"/>
                <xsl:if test="price/@concession">
                    <br/>
                    <span class="note">
                        <xsl:text>conc. &#163;</xsl:text>
                        <xsl:value-of select="price/@concession"/>
                    </span>
                </xsl:if>
            </td>
        </tr>
    </xsl:template>

</xsl:stylesheet>
