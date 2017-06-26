cd /home/lukas/jekyll/lukaswebsite/
jekyll build
rm -rf /home/lukas/docs/*
echo 'deleting old website'
mv /home/lukas/jekyll/lukaswebsite/_site/* /home/lukas/docs/
echo 'Moving new website'
