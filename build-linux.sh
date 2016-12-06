#!/bin/bash
set -x
set -e

#[Getting-Started](http://pandoc.org/getting-started.html)
# Dependency needed http://tex.stackexchange.com/questions/43108/texlive-does-not-find-sty-file
# Hello from ITMO 544-444

STAMP=`date +%m%d%y-%H%M%S`


#delete previous build artifacts but not the README.md
rm -f ./output/pdf/*.pdf
rm -f ./output/epub/*.epub
rm -f ./output/html/*.html
rm -f ./output/docx/*.docx
rm -f ./output/odt/*.odt

#######################################################################################################################
# PDF - #If you want to create a PDF, you’ll need to have LaTeX installed. (See MacTeX on OS X, MiKTeX on Windows, or
# install the texlive package in linux.) Then do                
########################################################################################################################
# --chapters starts chapters on odd number pages  
# List of fonts in Ubuntu texlive-fonts-extra https://launchpad.net/ubuntu/trusty/+package/texlive-fonts-extra
# What font packages are installed in TeX live? http://tex.stackexchange.com/questions/59403/what-font-packages-are-installed-in-tex-live
pandoc --toc -V geometry:margin=.75in --number-sections -V documentclass=report -V linkcolor=blue  --variable=fontfamily:arev -s -t latex   -o ./output/pdf/Understanding-Free-and-Opensource-Operating-Systems-Part-I-$STAMP.pdf ./Chapter-01/chapter-01.md ./Chapter-02/chapter-02.md ./Chapter-03/chapter-03.md ./Chapter-04/chapter-04.md ./Chapter-05/chapter-05.md ./Chapter-06/chapter-06.md ./Chapter-07/chapter-07.md ./Chapter-08/chapter-08.md ./Chapter-09/chapter-09.md ./Chapter-10/chapter-10.md ./Chapter-11/chapter-11.md ./Chapter-12/chapter-12.md ./Chapter-13/chapter-13.md ./Chapter-14/chapter-14.md ./Chapter-15/chapter-15.md ./Appendix-A/Appendix-A.md ./Appendix-B/Appendix-B.md ./Appendix-C/Appendix-C.md
# http://stackoverflow.com/questions/19397100/adding-a-title-page-page-headers-and-footers-using-pandoc

#################################################################
# EPUB - To convert it to EPUB, use this command:               #
#################################################################

pandoc --toc --number-sections --epub-stylesheet=css/epub/book-style.css --epub-cover-image=images/Chapter-Header/Cover/John_Calvin_by_Holbein.png -S -o ./output/epub/Understanding-Free-and-Opensource-Operating-Systems-Part-I-$STAMP.epub  ./Chapter-01/chapter-01.md ./Chapter-02/chapter-02.md ./Chapter-03/chapter-03.md ./Chapter-04/chapter-04.md ./Chapter-05/chapter-05.md ./Chapter-06/chapter-06.md ./Chapter-07/chapter-07.md ./Chapter-08/chapter-08.md ./Chapter-09/chapter-09.md ./Chapter-10/chapter-10.md ./Chapter-11/chapter-11.md ./Chapter-12/chapter-12.md ./Chapter-13/chapter-13.md ./Chapter-14/chapter-14.md ./Chapter-15/chapter-15.md  ./Appendix-A/Appendix-A.md ./Appendix-B/Appendix-B.md ./Appendix-C/Appendix-C.md
 
##################################################################
# HTML5 - To convert it to HTML, use this command:              #
################################################################## 

pandoc --toc -S -f markdown -t html5 -o ./output/html/Understanding-Free-and-Opensource-Operating-Systems-Part-I-$STAMP.html ./title/title.txt ./Chapter-01/chapter-01.md ./Chapter-02/chapter-02.md ./Chapter-03/chapter-03.md ./Chapter-04/chapter-04.md ./Chapter-05/chapter-05.md ./Chapter-06/chapter-06.md ./Chapter-07/chapter-07.md ./Chapter-08/chapter-08.md ./Chapter-09/chapter-09.md ./Chapter-10/chapter-10.md ./Chapter-11/chapter-11.md ./Chapter-12/chapter-12.md ./Chapter-13/chapter-13.md ./Chapter-14/chapter-14.md ./Chapter-15/chapter-15.md ./Appendix-A/Appendix-A.md ./Appendix-B/Appendix-B.md 

#############################################################################################################################
# DOCX - [Convert your Markdown file to Word (docx):](http://bob.yexley.net/generate-a-word-document-from-markdown-on-os-x/)#############################################################################################################################

pandoc --toc -o ./output/docx/Understanding-Free-and-Opensource-Operating-Systems-Part-I-$STAMP.docx -f markdown -t docx ./title/title.txt  ./Chapter-01/chapter-01.md ./Chapter-02/chapter-02.md ./Chapter-03/chapter-03.md ./Chapter-04/chapter-04.md ./Chapter-05/chapter-05.md ./Chapter-06/chapter-06.md ./Chapter-07/chapter-07.md ./Chapter-08/chapter-08.md ./Chapter-09/chapter-09.md ./Chapter-10/chapter-10.md ./Chapter-11/chapter-11.md ./Chapter-12/chapter-12.md ./Chapter-13/chapter-13.md ./Chapter-14/chapter-14.md ./Chapter-15/chapter-15.md  ./Appendix-A/Appendix-A.md ./Appendix-B/Appendix-B.md 

#############################################################################################################################
# ODT OpenOffice Document Format

pandoc --toc -o ./output/odt/Understanding-Free-and-Opensource-Operating-Systems-Part-I-$STAMP.odt -f markdown -t odt ./Chapter-01/chapter-01.md ./Chapter-02/chapter-02.md ./Chapter-03/chapter-03.md ./Chapter-04/chapter-04.md ./Chapter-05/chapter-05.md ./Chapter-06/chapter-06.md ./Chapter-07/chapter-07.md ./Chapter-08/chapter-08.md ./Chapter-09/chapter-09.md ./Chapter-10/chapter-10.md ./Chapter-11/chapter-11.md ./Chapter-12/chapter-12.md ./Chapter-13/chapter-13.md ./Chapter-14/chapter-14.md ./Chapter-15/chapter-15.md  ./Appendix-A/Appendix-A.md ./Appendix-B/Appendix-B.md



######################
# Debugging          #
######################

#cp  C:\Users\palad\Documents\Linux-text-book-part-1\output\pdf\*.pdf  C:\Users\palad\OneDrive\Documents\epub
#cp  C:\Users\palad\Documents\Linux-text-book-part-1\output\epub\*.epub  C:\Users\palad\OneDrive\Documents\epub

#[Convert to epub](http://pandoc.org/epub.html)
#pandoc ./Chapter-Table-of-Contents/chapter-toc.md ./Introduction/introduction.md ./Chapter-01/chapter-01.md -o ./output/Linux-Technology-and-Philosophy-Part-II.epub

# ODT demo http://pandoc.org/demos.html
#pandoc ./Chapter-Table-of-Contents/chapter-toc.md ./Introduction/introduction.md ./Chapter-01/chapter-01.md -o ./output/Linux-Technology-and-Philosophy-Part-II.odt
