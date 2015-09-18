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
If (Test-Path "./output/test-pdf-docx/Understanding-the-Technology-and-Philosophy-of-Linux-Part-I*"){
  Remove-Item -force -v -path ./output/test-pdf-docx/*.pdf
  Remove-Item -force -v -path ./output/test-pdf-docx/*.docx
  Remove-Item -force -v -path ./output/test-pdf-docx/*.epub
  Remove-Item -force -v -path ./output/test-pdf-docx/*.odt
}Else{
  echo "Filez don't exist =("
}

# http://stackoverflow.com/questions/4192971/in-powershell-how-do-i-convert-datetime-to-unix-time/25916431#25916431
$STAMP=[Math]::Floor([decimal](Get-Date(Get-Date).ToUniversalTime()-uformat "%s"))

#######################################################################################################################
# PDF - #If you want to create a PDF, you’ll need to have LaTeX installed. (See MacTeX on OS X, MiKTeX on Windows, or
# install the texlive package in linux.) Then do                
########################################################################################################################
#pandoc --toc -V geometry:margin=1in --number-sections --include-in-header ./title/titlesec.tex -s -o ./output/test-pdf-docx/Understanding-the-Technology-and-Philosophy-of-Linux-Part-I-$STAMP.pdf ./Chapter-01/chapter-01.md ./Chapter-02/chapter-02.md ./Chapter-03/chapter-03.md ./Chapter-04/chapter-04.md ./Chapter-05/chapter-05.md 
pandoc --toc -V geometry:margin=1in --number-sections --include-in-header ./title/titlesec.tex -s -o ./output/test-pdf-docx/Understanding-the-Technology-and-Philosophy-of-Linux-Part-I-$STAMP.pdf ./Chapter-01/chapter-01.md ./Chapter-02/chapter-02.md ./Chapter-03/chapter-03.md ./Chapter-04/chapter-04.md ./Chapter-05/chapter-05.md ./Appendix-A/Appendix-A.md
# http://stackoverflow.com/questions/19397100/adding-a-title-page-page-headers-and-footers-using-pandoc

#############################################################################################################################
# DOCX - [Convert your Markdown file to Word (docx):](http://bob.yexley.net/generate-a-word-document-from-markdown-on-os-x/)#############################################################################################################################
#############################################################################################################################
pandoc --toc --number-sections -o ./output/test-pdf-docx/Understanding-the-Technology-and-Philosophy-of-Linux-Part-I-$STAMP.docx -f markdown -t docx ./title/title.txt  ./Chapter-01/chapter-01.md ./Chapter-02/chapter-02.md ./Chapter-03/chapter-03.md ./Chapter-04/chapter-04.md ./Chapter-05/chapter-05.md ./Appendix-A/Appendix-A.md

#############################################################################################################################
# ODT
#############################################################################################################################
pandoc --toc --number-sections -o ./output/test-pdf-docx/Understanding-the-Technology-and-Philosophy-of-Linux-Part-I-$STAMP.odt -f markdown ./title/titlesec.tex  ./Chapter-01/chapter-01.md ./Chapter-02/chapter-02.md ./Chapter-03/chapter-03.md ./Chapter-04/chapter-04.md ./Chapter-05/chapter-05.md ./Appendix-A/Appendix-A.md

#################################################################
# EPUB - To convert it to EPUB, use this command:               #
#################################################################
pandoc --toc --number-sections --epub-cover-image=images/John_Calvin_by_Holbein.png -S -o ./output/test-pdf-docx/Understanding-the-Technology-and-Philosophy-of-Linux-Part-I-$STAMP.epub ./Chapter-01/chapter-01.md ./Chapter-02/chapter-02.md ./Chapter-03/chapter-03.md ./Chapter-04/chapter-04.md ./Chapter-05/chapter-05.md ./Appendix-A/Appendix-A.md 
 
######################
# Debugging          #
######################
#cp -Force C:\Users\palad\Documents\Linux-text-book-part-1\output\test-pdf-docx\Understanding-the-Technology-and-Philosophy-of-Linux-Part-I-$STAMP.pdf  C:\Users\palad\OneDrive\Documents\epub
#cp -Force C:\Users\palad\Documents\Linux-text-book-part-1\output\test-pdf-docx\Understanding-the-Technology-and-Philosophy-of-Linux-Part-I-$STAMP.docx C:\Users\palad\OneDrive\Documents\epub
#cp -Force C:\Users\palad\Documents\Linux-text-book-part-1\output\test-pdf-docx\Understanding-the-Technology-and-Philosophy-of-Linux-Part-I-$STAMP.odt C:\Users\palad\OneDrive\Documents\epub
###########################################
# Generate Kindle .mobi using Kindlegen   #
###########################################
#kindlegen ./output/epub/Understanding-the-Technology-and-Philosophy-of-Linux-Part-I.epub 
#mv ./output/epub/Understanding-the-Technology-and-Philosophy-of-Linux-Part-I.mobi ./output/mobi/Understanding-the-Technology-and-Philosophy-of-Linux-Part-I.mobi

