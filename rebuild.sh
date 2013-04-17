## NOT TESTED

mv _site/.git      extras/
mv _site/CNAME     extras/
mv _site/README.md extras/

./site clean
./site build

mv extras/.git      _site/
mv extras/CNAME     _site/
mv extras/README.md _site/
