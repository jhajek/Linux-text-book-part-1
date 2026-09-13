# Code for pushing a textbook release to GitHub via the gh cli
# This requires your device or laptop to be pre-authenticated with GitHub
# otherwise this won't work

$STAMP=Get-Date(Get-Date).ToUniversalTime() -uformat "%Y-%m-%d.%H%M%S"
$PDF_PATH='./output/pdf/Understanding-Free-and-Opensource-Operating-Systems-Part-I.pdf'
$EPUB_PATH='./output/epub/Understanding-Free-and-Opensource-Operating-Systems-Part-I.epub'

git tag -a $STAMP -m "Opensource Textbook build at $STAMP"
git push origin $STAMP

# Retrieve PREVIOUS commit tag
$PREV=git describe --tags --abbrev=0 HEAD^
$NOTES="$(git log $PREV..HEAD --pretty=format:'- %s (%h)')"

gh release create $STAMP $PDF_PATH $EPUB_PATH --title $STAMP --notes $NOTES
