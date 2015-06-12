#!/bin/bash

set -x
set -e

sudo apt-get -y install pandoc pandoc-citeproc texlive

rm -rf ./output/*

#[Getting-Started](http://pandoc.org/getting-started.html)

#If you want to create a PDF, you’ll need to have LaTeX installed. (See MacTeX on OS X, MiKTeX on Windows, or install the texlive package in linux.) Then do
pandoc ./Linux-Technology-and-Philosophy-Part-I.md -s -o ./output/Linux-Technology-and-Philosophy-Part-I.pdf

#To convert it to HTML, use this command:
pandoc ./Linux-Technology-and-Philosophy-Part-I.md -f markdown -t html -s -o ./output/Linux-Technology-and-Philosophy-Part-I.html

#[Convert your Markdown file to Word (docx):](http://bob.yexley.net/generate-a-word-document-from-markdown-on-os-x/)
pandoc -o ./output/Linux-Technology-and-Philosophy-Part-I.docx -f markdown -t docx ./Linux-Technology-and-Philosophy-Part-I.md

#[Convert to epub](http://pandoc.org/epub.html)
pandoc ./Linux-Technology-and-Philosophy-Part-I.md -o ./output/Linux-Technology-and-Philosophy-Part-I.epub