THE GRAND ROYALE THEATRE - WEBSITE
==================================

A two-page theatre website written by hand in a plain text editor.
No frameworks, no libraries, no build step - just HTML, CSS, XML, DTD and XSL.


FILES
-----
index.html    The main page (HTML). Theatre introduction, resident company,
              opening times, address and contact details.
style.css     The stylesheet. Used by BOTH pages, so they look like one site.
program.xml   The program page (XML). The season's productions as pure data.
program.dtd   The Document Type Definition. Defines the rules program.xml
              must obey (which elements, in what order, which attributes).
program.xsl   The XSL stylesheet. Transforms program.xml into an HTML table
              when the page is opened in a browser.

index.html and program.xml each contain a link to the other (in the top
navigation bar and again in the footer).


HOW TO VIEW IT  ***PLEASE READ***
---------------------------------
index.html can simply be double-clicked - it opens in any browser.

program.xml is different. Because it is transformed by an XSL stylesheet,
Chrome and Edge REFUSE to run the transformation when the file is opened
straight from your hard disk (a security rule: they treat every local file
as a separate origin and block program.xsl from loading). If you double-click
program.xml in Chrome you will just see the raw XML tree, not the table.
This is a browser restriction, not a fault in the code.

There are two ways to see it working properly:

  1. OPEN IT IN FIREFOX.
     Firefox does apply XSL to local files, so you can just double-click
     program.xml and the table appears. Easiest option.

  2. RUN IT THROUGH A LOCAL WEB SERVER (works in every browser).
     Open a terminal/command prompt in this folder and run:

         python -m http.server 8000

     then visit  http://localhost:8000/index.html  in any browser.
     (Any web server will do - XAMPP, WAMP, VS Code's "Live Server"
     extension, or real web hosting. On a live website it always works.)


HOW THE REQUIREMENTS ARE MET
----------------------------
HTML          index.html - semantic structure: header, nav, main, sections,
              footer, address.
              Contains a paragraph (theatre introduction), a list (the
              resident company of actors) and a table (opening times), as
              required.

CSS           style.css - element/class/ID selectors, descendant selectors,
              pseudo-classes (:hover), the structural pseudo-class
              nth-child(even) for zebra-striped tables, the box model,
              flexbox for the contact panels, a gradient, and a media query
              so the site reflows on a phone.

XML           program.xml - the program stored as structured data, with a
              root <program> element and one <show> element per production.
              Also demonstrates general entities (&theatre; and &interval;)
              declared in the internal DTD subset.

DTD           program.dtd - declares every element and its content model,
              using the +, ? and (a|b) operators; declares attributes with
              types ID, CDATA and an enumerated list; and uses #REQUIRED,
              #IMPLIED and a default value ("Main" for the stage attribute).
              program.xml has been validated against it and passes cleanly.

TRANSFORM     program.xsl - an XSLT 1.0 stylesheet. It uses xsl:template,
              xsl:apply-templates, xsl:for-each, xsl:value-of, xsl:if and
              the count() function to turn the XML into a formatted HTML
              table. program.xml points at it with an <?xml-stylesheet?>
              processing instruction, so the browser does the transformation
              automatically when the page is opened.

LINKING       Both pages link to each other with <a> tags.


VALIDATING THE XML YOURSELF
---------------------------
If you have xmllint installed:

    xmllint --noout --valid program.xml

It prints nothing when the document is valid. (It has been checked - it is.)
