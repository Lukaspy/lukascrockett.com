cd /home/lukas/lukascrockett.com
jekyll build
rm -rf /home/lukas/docs/*
echo 'deleting old website'
mv /home/lukas/lukascrockett.com/_site/* /home/lukas/docs/
echo 'Moving new website'
