mv _site/.git      tmp
mv _site/CNAME     tmp
mv _site/README.md tmp

./site clean
./site build

mv tmp/.git      _site
mv tmp/CNAME     _site
mv tmp/README.md _site
