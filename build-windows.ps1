# How to allow Powershell scripts to run
# From an elevated Powershell promt type: Set-ExecutionPolicy RemoteSigned
# answer Yes to all

# This is to force the user to add a command line parameter to turn on debugging if needed
# https://stackoverflow.com/questions/2157554/how-to-handle-command-line-arguments-in-powershell
 param (
    [switch]$debug = $false,
    [switch]$kindlegen = $false
 )
# Go to end of file to see debugging

# setup git user.name and user.email
# http://www.git-scm.com/book/en/v2/Getting-Started-First-Time-Git-Setup
# git config --global user.name "John Doe"
# git config --global user.email johndoe@example.com

#[Getting-Started](http://pandoc.org/getting-started.html)

# http://stevehardie.com/2013/04/powershell-check-if-file-exists/
# http://www.powershelladmin.com/wiki/Powershell_multi-line_comments
#delete previous build artifacts but not the README.md
If (Test-Path "./output/pdf/Understanding-Free-and-Opensource-Operating-Systems-Part-I*"){
  rm -v ./output/pdf/*.pdf
}Else{
  echo "./output/pdf/Understanding-Free-and-Opensource-Operating-Systems-Part-I.pdf - File does not exist =("
}

If (Test-Path "./output/epub/Understanding-Free-and-Opensource-Operating-Systems-Part-I*"){
  rm -v ./output/epub/*.epub
}Else{
  echo "./output/epub/Understanding-Free-and-Opensource-Operating-Systems-Part-I.epub - File does not exist =("
}

If (Test-Path "./output/html/Understanding-Free-and-Opensource-Operating-Systems-Part-I*"){
  rm -v ./output/html/*.html
}Else{
  echo "./output/html/Understanding-Free-and-Opensource-Operating-Systems-Part-I.html - File does not exist =("
}

If (Test-Path "./output/docx/Understanding-Free-and-Opensource-Operating-Systems-Part-I*"){
  rm -v ./output/docx/*.docx
}Else{
  echo "./output/docx/Understanding-Free-and-Opensource-Operating-Systems-Part-I.docx - File does not exist =("
}

If (Test-Path "./output/odt/Understanding-Free-and-Opensource-Operating-Systems-Part-I*"){
  rm -v ./output/odt/*.odt
}Else{
  echo "./output/odt/Understanding-Free-and-Opensource-Operating-Systems-Part-I.odt - File does not exist =("
}
# Debugging - you may not need this
<#
If (Test-Path "C:\Users\palad\OneDrive\Documents\epub\Understanding-Free-and-Opensource-Operating-Systems-Part-I*.epub"){
  echo "Removing previous epub version"
  rm -v "C:\Users\palad\OneDrive\Documents\epub\Understanding-Free-and-Opensource-Operating-Systems-Part-I*.epub"
}Else{
  echo "C:\Users\palad\OneDrive\Documents\epub\Understanding-Free-and-Opensource-Operating-Systems-Part-I.epub - File does not exist =("
}
#>

<#
If (Test-Path ./output/mobi/Understanding-Free-and-Opensource-Operating-Systems-Part-I.mobi){
  # http://stevehardie.com/2013/04/powershell-check-if-file-exists/
  rm -v ./output/mobi/*.mobi
}Else{
  echo "./output/mobi/Understanding-Free-and-Opensource-Operating-Systems-Part-I.mobi - File does not exist =("
}
#>

$STAMP=[Math]::Floor([decimal](Get-Date(Get-Date).ToUniversalTime()-uformat "%s"))

#######################################################################################################################
# PDF - for e-reader 
# If you want to create a PDF, you’ll need to have LaTeX installed. (See MacTeX on OS X, MiKTeX on Windows, or
# install the texlive package in linux.) Then do                
########################################################################################################################
pandoc --toc -V geometry:margin=1in --number-sections -V documentclass=report -V linkcolor=blue -V fontsize=12pt -t latex -o ./output/pdf/Understanding-Free-and-Opensource-Operating-Systems-Part-I-$STAMP.pdf ./Chapter-01/chapter-01.md ./Chapter-02/chapter-02.md ./Chapter-03/chapter-03.md ./Chapter-04/chapter-04.md ./Chapter-05/chapter-05.md ./Chapter-06/chapter-06.md ./Chapter-07/chapter-07.md ./Chapter-08/chapter-08.md ./Chapter-09/chapter-09.md ./Chapter-10/chapter-10.md ./Chapter-11/chapter-11.md ./Chapter-12/chapter-12.md ./Chapter-13/chapter-13.md ./Chapter-14/chapter-14.md ./Chapter-15/chapter-15.md ./Appendix-A/Appendix-A.md ./Appendix-B/Appendix-B.md ./Appendix-C/Appendix-C.md 
# http://stackoverflow.com/questions/19397100/adding-a-title-page-page-headers-and-footers-using-pandoc
# See this link to explain font name craziness-- https://github.com/jgm/pandoc/wiki/Trials-and-Tribulations%3A-How-to-find-correct-font-names-for-Pandoc%27s-use-with-LuaLaTeX%3F
# Manual Font install - http://tex.stackexchange.com/questions/88423/manual-font-installation
#######################################################################################################################
# PDF - for paper printing
# If you want to create a PDF, you’ll need to have LaTeX installed. (See MacTeX on OS X, MiKTeX on Windows, or
# install the texlive package in linux.) Then do   
########################################################################################################################
pandoc --toc -V geometry:margin=.75in -V paperwidth=6.14in -V paperheight=9.25in --number-sections -V documentclass=report -V linkcolor=blue --variable mainfont="Charis SIL" -V sansfont="Charis SIL" -s -t latex -o ./output/pdf/Understanding-Free-and-Opensource-Operating-Systems-Part-I-PRINT-$STAMP.pdf ./Chapter-01/chapter-01.md ./Chapter-02/chapter-02.md ./Chapter-03/chapter-03.md ./Chapter-04/chapter-04.md ./Chapter-05/chapter-05.md ./Chapter-06/chapter-06.md ./Chapter-07/chapter-07.md ./Chapter-08/chapter-08.md ./Chapter-09/chapter-09.md ./Chapter-10/chapter-10.md ./Chapter-11/chapter-11.md ./Chapter-12/chapter-12.md ./Chapter-13/chapter-13.md ./Chapter-14/chapter-14.md ./Chapter-15/chapter-15.md ./Appendix-A/Appendix-A.md ./Appendix-B/Appendix-B.md ./Appendix-C/Appendix-C.md 
# http://tex.stackexchange.com/questions/78920/generating-smartphone-readable-pdf

#################################################################
# EPUB - To convert it to EPUB, use this command:               #
#################################################################

pandoc --toc --number-sections --epub-stylesheet=css/epub/book-style.css --epub-cover-image=images/Chapter-Header/Cover/John_Calvin_by_Holbein.png -o ./output/epub/Understanding-Free-and-Opensource-Operating-Systems-Part-I-$STAMP.epub ./Chapter-01/chapter-01.md ./Chapter-02/chapter-02.md ./Chapter-03/chapter-03.md ./Chapter-04/chapter-04.md ./Chapter-05/chapter-05.md ./Chapter-06/chapter-06.md ./Chapter-07/chapter-07.md ./Chapter-08/chapter-08.md ./Chapter-09/chapter-09.md ./Chapter-10/chapter-10.md ./Chapter-11/chapter-11.md ./Chapter-12/chapter-12.md ./Chapter-13/chapter-13.md ./Chapter-14/chapter-14.md ./Chapter-15/chapter-15.md  ./Appendix-A/Appendix-A.md ./Appendix-B/Appendix-B.md ./Appendix-C/Appendix-C.md 
 
##################################################################
# HTML5 - To convert it to HTML, use this command:              #
################################################################## 

pandoc --toc -s -f markdown -t html5 -V mainfont="Lucida Consolas" -V sansfont="GNU Freefont Sans" -o ./output/html/Understanding-Free-and-Opensource-Operating-Systems-Part-I-$STAMP.html ./title/title.txt ./Chapter-01/chapter-01.md ./Chapter-02/chapter-02.md ./Chapter-03/chapter-03.md ./Chapter-04/chapter-04.md ./Chapter-05/chapter-05.md ./Chapter-06/chapter-06.md ./Chapter-07/chapter-07.md ./Chapter-08/chapter-08.md ./Chapter-09/chapter-09.md ./Chapter-10/chapter-10.md ./Chapter-11/chapter-11.md ./Chapter-12/chapter-12.md ./Chapter-13/chapter-13.md ./Chapter-14/chapter-14.md ./Chapter-15/chapter-15.md  ./Appendix-A/Appendix-A.md ./Appendix-B/Appendix-B.md ./Appendix-C/Appendix-C.md

#############################################################################################################################
# DOCX - [Convert your Markdown file to Word (docx):](http://bob.yexley.net/generate-a-word-document-from-markdown-on-os-x/)#############################################################################################################################

pandoc --toc --number-sections -V documentclass=report -s -o ./output/docx/Understanding-Free-and-Opensource-Operating-Systems-Part-I-$STAMP.docx -f markdown -t docx ./title/title.txt  ./Chapter-01/chapter-01.md ./Chapter-02/chapter-02.md ./Chapter-03/chapter-03.md ./Chapter-04/chapter-04.md ./Chapter-05/chapter-05.md ./Chapter-06/chapter-06.md ./Chapter-07/chapter-07.md ./Chapter-08/chapter-08.md ./Chapter-09/chapter-09.md ./Chapter-10/chapter-10.md ./Chapter-11/chapter-11.md ./Chapter-12/chapter-12.md ./Chapter-13/chapter-13.md ./Chapter-14/chapter-14.md ./Chapter-15/chapter-15.md  ./Appendix-A/Appendix-A.md ./Appendix-B/Appendix-B.md ./Appendix-C/Appendix-C.md

#############################################################################################################################
# ODT OpenOffice Document Format

pandoc --toc --number-sections -s -o ./output/odt/Understanding-Free-and-Opensource-Operating-Systems-Part-I-$STAMP.odt -f markdown ./title/title.txt  ./Chapter-01/chapter-01.md ./Chapter-02/chapter-02.md ./Chapter-03/chapter-03.md ./Chapter-04/chapter-04.md ./Chapter-05/chapter-05.md ./Chapter-06/chapter-06.md ./Chapter-07/chapter-07.md ./Chapter-08/chapter-08.md ./Chapter-09/chapter-09.md ./Chapter-10/chapter-10.md ./Chapter-11/chapter-11.md ./Chapter-12/chapter-12.md ./Chapter-13/chapter-13.md ./Chapter-14/chapter-14.md ./Chapter-15/chapter-15.md  ./Appendix-A/Appendix-A.md ./Appendix-B/Appendix-B.md ./Appendix-C/Appendix-C.md

######################
# Debugging          #
######################

# cp -Force C:\Users\palad\Documents\Linux-text-book-part-1\output\pdf\*.pdf  C:\Users\palad\OneDrive\Documents\epub
if( $debug ) { 
cp -Force  d:\Linux-text-book-part-1\output\epub\*.epub  D:\Users\palad\OneDrive\Documents\epub\Understanding-Free-and-Opensource-Operating-Systems
}
###########################################
# Generate Kindle .mobi using Kindlegen   #
###########################################
if ( $kindlegen ) {
kindlegen ./output/epub/Understanding-Free-and-Opensource-Operating-Systems-Part-I.epub 
mv ./output/epub/Understanding-Free-and-Opensource-Operating-Systems-Part-I.mobi ./output/mobi/Understanding-Free-and-Opensource-Operating-Systems-Part-I.mobi
}
