asciidoctor -o index.html -a nofooter index.adoc
asciidoctor -o miscellaneous-articles.html -a nofooter miscellaneous-articles.adoc

git add --all
git commit -m "Publish site"
git push