#[Getting-Started](http://pandoc.org/getting-started.html)

# http://stevehardie.com/2013/04/powershell-check-if-file-exists/
# http://www.powershelladmin.com/wiki/Powershell_multi-line_comments
#delete previous build artifacts but not the README.md
If (Test-Path ./output/test-pdf-docx/Understanding-the-Technology-and-Philosophy-of-Linux-Part-I*){
  Remove-Item -force -v -path ./output/test-pdf-docx/*.pdf
  Remove-Item -force -v -path ./output/test-pdf-docx/*.docx
}Else{
  echo "Filez don't exist =("
}

# http://stackoverflow.com/questions/4192971/in-powershell-how-do-i-convert-datetime-to-unix-time/25916431#25916431
$STAMP=[Math]::Floor([decimal](Get-Date(Get-Date).ToUniversalTime()-uformat "%s"))

#######################################################################################################################
# PDF - #If you want to create a PDF, you’ll need to have LaTeX installed. (See MacTeX on OS X, MiKTeX on Windows, or
# install the texlive package in linux.) Then do                
########################################################################################################################
pandoc --toc -V geometry:margin=1in --number-sections --include-in-header ./title/titlesec.tex -s -o ./output/test-pdf-docx/Understanding-the-Technology-and-Philosophy-of-Linux-Part-I-$STAMP.pdf ./Chapter-01/chapter-01.md ./Chapter-02/chapter-02.md ./Chapter-03/chapter-03.md ./Chapter-04/chapter-04.md  
# http://stackoverflow.com/questions/19397100/adding-a-title-page-page-headers-and-footers-using-pandoc

#############################################################################################################################
# DOCX - [Convert your Markdown file to Word (docx):](http://bob.yexley.net/generate-a-word-document-from-markdown-on-os-x/)#############################################################################################################################
#############################################################################################################################
pandoc --toc --number-sections -o ./output/test-pdf-docx/Understanding-the-Technology-and-Philosophy-of-Linux-Part-I-$STAMP.docx -f markdown -t docx ./title/title.txt  ./Chapter-01/chapter-01.md ./Chapter-02/chapter-02.md ./Chapter-03/chapter-03.md 
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

