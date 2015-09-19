# How to allow Powershell scripts to run
# From an elevated Powershell promt type: Set-ExecutionPolicy RemoteSigned
# answer Yes to all

# setup git user.name and user.email
# http://www.git-scm.com/book/en/v2/Getting-Started-First-Time-Git-Setup
# git config --global user.name "John Doe"
# git config --global user.email johndoe@example.com

#[Getting-Started](http://pandoc.org/getting-started.html)

# http://stevehardie.com/2013/04/powershell-check-if-file-exists/
# http://www.powershelladmin.com/wiki/Powershell_multi-line_comments
#delete previous build artifacts but not the README.md
If (Test-Path "./output/pdf/Understanding-the-Technology-and-Philosophy-of-Linux-Part-I*"){
  rm -v ./output/pdf/*.pdf
}Else{
  echo "./output/pdf/Understanding-the-Technology-and-Philosophy-of-Linux-Part-I.pdf - File does not exist =("
}

If (Test-Path "./output/epub/Understanding-the-Technology-and-Philosophy-of-Linux-Part-I*"){
  rm -v ./output/epub/*.epub
}Else{
  echo "./output/epub/Understanding-the-Technology-and-Philosophy-of-Linux-Part-I.epub - File does not exist =("
}

If (Test-Path "./output/html/Understanding-the-Technology-and-Philosophy-of-Linux-Part-I*"){
  rm -v ./output/html/*.html
}Else{
  echo "./output/html/Understanding-the-Technology-and-Philosophy-of-Linux-Part-I.html - File does not exist =("
}

If (Test-Path "./output/docx/Understanding-the-Technology-and-Philosophy-of-Linux-Part-I*"){
  rm -v ./output/docx/*.docx
}Else{
  echo "./output/docx/Understanding-the-Technology-and-Philosophy-of-Linux-Part-I.docx - File does not exist =("
}

If (Test-Path "./output/odt/Understanding-the-Technology-and-Philosophy-of-Linux-Part-I*"){
  rm -v ./output/odt/*.odt
}Else{
  echo "./output/odt/Understanding-the-Technology-and-Philosophy-of-Linux-Part-I.odt - File does not exist =("
}

<#
If (Test-Path ./output/mobi/Understanding-the-Technology-and-Philosophy-of-Linux-Part-I.mobi){
  # http://stevehardie.com/2013/04/powershell-check-if-file-exists/
  rm -v ./output/mobi/*.mobi
}Else{
  echo "./output/mobi/Understanding-the-Technology-and-Philosophy-of-Linux-Part-I.mobi - File does not exist =("
}
#>

$STAMP=[Math]::Floor([decimal](Get-Date(Get-Date).ToUniversalTime()-uformat "%s"))

#######################################################################################################################
# PDF - #If you want to create a PDF, you’ll need to have LaTeX installed. (See MacTeX on OS X, MiKTeX on Windows, or
# install the texlive package in linux.) Then do                
########################################################################################################################
pandoc --toc -V geometry:margin=1in --number-sections --include-in-header ./title/titlesec.tex -s -o ./output/pdf/Understanding-the-Technology-and-Philosophy-of-Linux-Part-I-$STAMP.pdf ./Chapter-01/chapter-01.md ./Chapter-02/chapter-02.md ./Chapter-03/chapter-03.md ./Chapter-04/chapter-04.md ./Chapter-05/chapter-05.md ./Chapter-06/chapter-06.md ./Chapter-07/chapter-07.md ./Chapter-08/chapter-08.md ./Chapter-09/chapter-09.md ./Chapter-10/chapter-10.md ./Chapter-11/chapter-11.md ./Chapter-12/chapter-12.md ./Chapter-13/chapter-13.md ./Chapter-14/chapter-14.md ./Chapter-15/chapter-15.md ./Appendix-A/Appendix-A.md ./Appendix-B/Appendix-B.md 
# http://stackoverflow.com/questions/19397100/adding-a-title-page-page-headers-and-footers-using-pandoc

#################################################################
# EPUB - To convert it to EPUB, use this command:               #
#################################################################

pandoc --toc --number-sections --epub-cover-image=images/Chapter-Header/Cover/John_Calvin_by_Holbein.png -S -o ./output/epub/Understanding-the-Technology-and-Philosophy-of-Linux-Part-I-$STAMP.epub ./Chapter-01/chapter-01.md ./Chapter-02/chapter-02.md ./Chapter-03/chapter-03.md ./Chapter-04/chapter-04.md ./Chapter-05/chapter-05.md ./Chapter-06/chapter-06.md ./Chapter-07/chapter-07.md ./Chapter-08/chapter-08.md ./Chapter-09/chapter-09.md ./Chapter-10/chapter-10.md ./Chapter-11/chapter-11.md ./Chapter-12/chapter-12.md ./Chapter-13/chapter-13.md ./Chapter-14/chapter-14.md ./Chapter-15/chapter-15.md  ./Appendix-A/Appendix-A.md ./Appendix-B/Appendix-B.md 
 
##################################################################
# HTML5 - To convert it to HTML, use this command:              #
################################################################## 

pandoc --toc -S -s -f markdown -t html5 -o ./output/html/Understanding-the-Technology-and-Philosophy-of-Linux-Part-I-$STAMP.html ./title/title.txt ./Chapter-01/chapter-01.md ./Chapter-02/chapter-02.md ./Chapter-03/chapter-03.md ./Chapter-04/chapter-04.md ./Chapter-05/chapter-05.md ./Chapter-06/chapter-06.md ./Chapter-07/chapter-07.md ./Chapter-08/chapter-08.md ./Chapter-09/chapter-09.md ./Chapter-10/chapter-10.md ./Chapter-11/chapter-11.md ./Chapter-12/chapter-12.md ./Chapter-13/chapter-13.md ./Chapter-14/chapter-14.md ./Chapter-15/chapter-15.md  ./Appendix-A/Appendix-A.md ./Appendix-B/Appendix-B.md

#############################################################################################################################
# DOCX - [Convert your Markdown file to Word (docx):](http://bob.yexley.net/generate-a-word-document-from-markdown-on-os-x/)#############################################################################################################################

pandoc --toc --number-sections -o ./output/docx/Understanding-the-Technology-and-Philosophy-of-Linux-Part-I-$STAMP.docx -f markdown -t docx ./title/title.txt  ./Chapter-01/chapter-01.md ./Chapter-02/chapter-02.md ./Chapter-03/chapter-03.md ./Chapter-04/chapter-04.md ./Chapter-05/chapter-05.md ./Chapter-06/chapter-06.md ./Chapter-07/chapter-07.md ./Chapter-08/chapter-08.md ./Chapter-09/chapter-09.md ./Chapter-10/chapter-10.md ./Chapter-11/chapter-11.md ./Chapter-12/chapter-12.md ./Chapter-13/chapter-13.md ./Chapter-14/chapter-14.md ./Chapter-15/chapter-15.md  ./Appendix-A/Appendix-A.md ./Appendix-B/Appendix-B.md 

#############################################################################################################################
# ODT OpenOffice Document Format

pandoc --toc --number-sections -o ./output/odt/Understanding-the-Technology-and-Philosophy-of-Linux-Part-I-$STAMP.odt -f markdown ./title/title.txt  ./Chapter-01/chapter-01.md ./Chapter-02/chapter-02.md ./Chapter-03/chapter-03.md ./Chapter-04/chapter-04.md ./Chapter-05/chapter-05.md ./Chapter-06/chapter-06.md ./Chapter-07/chapter-07.md ./Chapter-08/chapter-08.md ./Chapter-09/chapter-09.md ./Chapter-10/chapter-10.md ./Chapter-11/chapter-11.md ./Chapter-12/chapter-12.md ./Chapter-13/chapter-13.md ./Chapter-14/chapter-14.md ./Chapter-15/chapter-15.md  ./Appendix-A/Appendix-A.md ./Appendix-B/Appendix-B.md

######################
# Debugging          #
######################

# cp -Force C:\Users\palad\Documents\Linux-text-book-part-1\output\pdf\*.pdf  C:\Users\palad\OneDrive\Documents\epub
# cp -Force  C:\Users\palad\Documents\Linux-text-book-part-1\output\epub\*.epub  C:\Users\palad\OneDrive\Documents\epub

###########################################
# Generate Kindle .mobi using Kindlegen   #
###########################################
#kindlegen ./output/epub/Understanding-the-Technology-and-Philosophy-of-Linux-Part-I.epub 
#mv ./output/epub/Understanding-the-Technology-and-Philosophy-of-Linux-Part-I.mobi ./output/mobi/Understanding-the-Technology-and-Philosophy-of-Linux-Part-I.mobi

