#!/bin/bash
set -e

#[Getting-Started](http://pandoc.org/getting-started.html)
# Dependency needed http://tex.stackexchange.com/questions/43108/texlive-does-not-find-sty-file
# Hello from ITMO 544-444

STAMP=`date +%m%d%Y-%H%M%S`

#delete previous build artifacts but not the README.md
rm -f ./output/pdf/*.pdf
rm -f ./output/epub/*.epub
rm -f ./output/html/*.html
rm -f ./output/docx/*.docx
rm -f ./output/odt/*.odt
rm -f ./output/txt/*.txt

#######################################################################################################################
# PDF - If you want to create a PDF, you’ll need to have LaTeX installed. (See MacTeX on OS X, MiKTeX on Windows, or
# install the texlive package in linux.) Then do                
########################################################################################################################
# --chapters starts chapters on odd number pages  
# List of fonts in Ubuntu texlive-fonts-extra https://launchpad.net/ubuntu/trusty/+package/texlive-fonts-extra
# What font packages are installed in TeX live? http://tex.stackexchange.com/questions/59403/what-font-packages-are-installed-in-tex-live
echo "Starting PDF Generation..."
pandoc --toc -V geometry:margin=.75in --number-sections -V documentclass=report -V linkcolor=blue -s -o ./output/pdf/Understanding-Free-and-Opensource-Operating-Systems-Part-I.pdf ./Chapter-01/chapter-01.md ./Chapter-02/chapter-02.md ./Chapter-03/chapter-03.md ./Chapter-04/chapter-04.md ./Chapter-05/chapter-05.md ./Chapter-06/chapter-06.md ./Chapter-07/chapter-07.md ./Chapter-08/chapter-08.md ./Chapter-09/chapter-09.md ./Chapter-10/chapter-10.md ./Chapter-11/chapter-11.md ./Chapter-12/chapter-12.md ./Chapter-13/chapter-13.md ./Chapter-14/chapter-14.md ./Appendix-A/Appendix-A.md ./Appendix-B/Appendix-B.md ./Appendix-C/Appendix-C.md ./Appendix-D/Appendix-D.md
echo "Completing PDF Generation..."
# http://stackoverflow.com/questions/19397100/adding-a-title-page-page-headers-and-footers-using-pandoc
#######################################################################################################################
# PDF - for paper printing
# If you want to create a PDF, you’ll need to have LaTeX installed. (See MacTeX on OS X, MiKTeX on Windows, or
# install the texlive package in linux.) Then do   
########################################################################################################################
echo "Starting Print PDF Generation..."
pandoc --toc -V geometry:margin=.75in -V paperwidth=6.14in -V paperheight=9.25in --number-sections -V documentclass=report -V linkcolor=blue -V fontsize=12pt -V mainfont="Charis SIL" -V monofont=Inconsolata -s  -t latex -o  ./output/pdf/Understanding-Free-and-Opensource-Operating-Systems-Part-I-PRINT.pdf ./Chapter-01/chapter-01.md ./Chapter-02/chapter-02.md ./Chapter-03/chapter-03.md ./Chapter-04/chapter-04.md ./Chapter-05/chapter-05.md ./Chapter-06/chapter-06.md ./Chapter-07/chapter-07.md ./Chapter-08/chapter-08.md ./Chapter-09/chapter-09.md ./Chapter-10/chapter-10.md ./Chapter-11/chapter-11.md ./Chapter-12/chapter-12.md ./Chapter-13/chapter-13.md ./Chapter-14/chapter-14.md ./Appendix-A/Appendix-A.md ./Appendix-B/Appendix-B.md ./Appendix-C/Appendix-C.md ./Appendix-D/Appendix-D.md
echo "Completing PDF Generation..."
# http://tex.stackexchange.com/questions/78920/generating-smartphone-readable-pdf

#################################################################
# EPUB - To convert it to EPUB, use this command:               #
#################################################################
echo "Starting ePub Generation..."
pandoc --toc --number-sections --css=css/epub/book-style.css --epub-cover-image=images/Chapter-Header/Cover/cover.jpg -o ./output/epub/Understanding-Free-and-Opensource-Operating-Systems-Part-I.epub  ./Chapter-01/chapter-01.md ./Chapter-02/chapter-02.md ./Chapter-03/chapter-03.md ./Chapter-04/chapter-04.md ./Chapter-05/chapter-05.md ./Chapter-06/chapter-06.md ./Chapter-07/chapter-07.md ./Chapter-08/chapter-08.md ./Chapter-09/chapter-09.md ./Chapter-10/chapter-10.md ./Chapter-11/chapter-11.md ./Chapter-12/chapter-12.md ./Chapter-13/chapter-13.md ./Chapter-14/chapter-14.md ./Appendix-A/Appendix-A.md ./Appendix-B/Appendix-B.md ./Appendix-C/Appendix-C.md ./Appendix-D/Appendix-D.md
echo "Completing ePub Generation..."
##################################################################
# HTML5 - To convert it to HTML, use this command:              #
################################################################## 
echo "Starting HTML5 Generation..."
pandoc --toc -f markdown -t html5 -o ./output/html/Understanding-Free-and-Opensource-Operating-Systems-Part-I.html ./title/title.txt ./Chapter-01/chapter-01.md ./Chapter-02/chapter-02.md ./Chapter-03/chapter-03.md ./Chapter-04/chapter-04.md ./Chapter-05/chapter-05.md ./Chapter-06/chapter-06.md ./Chapter-07/chapter-07.md ./Chapter-08/chapter-08.md ./Chapter-09/chapter-09.md ./Chapter-10/chapter-10.md ./Chapter-11/chapter-11.md ./Chapter-12/chapter-12.md ./Chapter-13/chapter-13.md ./Appendix-A/Appendix-A.md ./Appendix-B/Appendix-B.md ./Appendix-C/Appendix-C.md ./Appendix-D/Appendix-D.md
echo "Completing HTML5 Generation..."
#############################################################################################################################
# DOCX - [Convert your Markdown file to Word (docx):](http://bob.yexley.net/generate-a-word-document-from-markdown-on-os-x/)#############################################################################################################################
echo "Starting docx Generation..."
pandoc --toc -o ./output/docx/Understanding-Free-and-Opensource-Operating-Systems-Part-I.docx -f markdown -t docx ./title/title.txt  ./Chapter-01/chapter-01.md ./Chapter-02/chapter-02.md ./Chapter-03/chapter-03.md ./Chapter-04/chapter-04.md ./Chapter-05/chapter-05.md ./Chapter-06/chapter-06.md ./Chapter-07/chapter-07.md ./Chapter-08/chapter-08.md ./Chapter-09/chapter-09.md ./Chapter-10/chapter-10.md ./Chapter-11/chapter-11.md ./Chapter-12/chapter-12.md ./Chapter-13/chapter-13.md ./Appendix-A/Appendix-A.md ./Appendix-B/Appendix-B.md ./Appendix-C/Appendix-C.md ./Appendix-D/Appendix-D.md
echo "Completing docx Generation..."
#############################################################################################################################
# ODT OpenOffice Document Format
echo "Starting ODT Generation..."
pandoc --toc -o ./output/odt/Understanding-Free-and-Opensource-Operating-Systems-Part-I.odt -f markdown -t odt ./Chapter-01/chapter-01.md ./Chapter-02/chapter-02.md ./Chapter-03/chapter-03.md ./Chapter-04/chapter-04.md ./Chapter-05/chapter-05.md ./Chapter-06/chapter-06.md ./Chapter-07/chapter-07.md ./Chapter-08/chapter-08.md ./Chapter-09/chapter-09.md ./Chapter-10/chapter-10.md ./Chapter-11/chapter-11.md ./Chapter-12/chapter-12.md ./Chapter-13/chapter-13.md ./Chapter-14/chapter-14.md ./Appendix-A/Appendix-A.md ./Appendix-B/Appendix-B.md ./Appendix-C/Appendix-C.md ./Appendix-D/Appendix-D.md
echo "Completing ODT Generation..."
##############################################################################
# Convert to .txt text but with formating
# https://stackoverflow.com/questions/34132549/pandoc-markdown-to-plain-text-formatting
echo "Starting txt Generation..."
pandoc -f markdown -t plain -V templates/defaults.txt --toc --number-sections -o ./output/txt/Understanding-Free-and-Opensource-Operating-Systems-Part-I.txt ./title/title.txt ./Chapter-01/chapter-01.md ./Chapter-02/chapter-02.md ./Chapter-03/chapter-03.md ./Chapter-04/chapter-04.md ./Chapter-05/chapter-05.md ./Chapter-06/chapter-06.md ./Chapter-07/chapter-07.md ./Chapter-08/chapter-08.md ./Chapter-09/chapter-09.md ./Chapter-10/chapter-10.md ./Chapter-11/chapter-11.md ./Chapter-12/chapter-12.md ./Chapter-13/chapter-13.md ./Chapter-14/chapter-14.md ./Appendix-A/Appendix-A.md ./Appendix-B/Appendix-B.md ./Appendix-C/Appendix-C.md ./Appendix-D/Appendix-D.md
echo "Completing txt Generation..."

######################
# Debugging          #
######################

#cp  C:\Users\palad\Documents\Linux-text-book-part-1\output\pdf\*.pdf  C:\Users\palad\OneDrive\Documents\epub
#cp  C:\Users\palad\Documents\Linux-text-book-part-1\output\epub\*.epub  C:\Users\palad\OneDrive\Documents\epub

#[Convert to epub](http://pandoc.org/epub.html)
#pandoc ./Chapter-Table-of-Contents/chapter-toc.md ./Introduction/introduction.md ./Chapter-01/chapter-01.md -o ./output/Linux-Technology-and-Philosophy-Part-II.epub

# ODT demo http://pandoc.org/demos.html
#pandoc ./Chapter-Table-of-Contents/chapter-toc.md ./Introduction/introduction.md ./Chapter-01/chapter-01.md -o ./output/Linux-Technology-and-Philosophy-Part-II.odt

echo "Success! You have built a copy of the book. =)"
 