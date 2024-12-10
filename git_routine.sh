asciidoctor -o index.html -a nofooter README.adoc

git add --all
git commit -m "Publish site"
git push