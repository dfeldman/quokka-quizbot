#!/bin/bash
cp frontend/index.html ~/webassets/labs/quokka/static/index.html
cp logos/* ~/webassets/labs/quokka/logos/
cp -rfv quizzes/* ~/webassets/labs/quokka/quizzes/
source ~/.awskeys
cd ~/webassets
aws s3 sync . s3://webassets.dfeldman.org
