#!/bin/bash
# Copy static files to webassets
pushd ~/work/quokka-quizbot
cp frontend/index.html ~/webassets/labs/quokka/static/index.html
cp logos/* ~/webassets/labs/quokka/logos/
cp -rfv quizzes/* ~/webassets/labs/quokka/quizzes/
cp -rfv testquizzes/* ~/webassets/labs/quokka/testquizzes/
popd

# Update webassets
source ~/.awskeys
pushd ~/webassets
aws s3 sync . s3://webassets.dfeldman.org
aws cloudfront create-invalidation \
    --distribution-id E3KT6H1BEEU8Q5 \
    --paths "/*" | cat
popd

# Update all the backend stuff on server
# Note: does not update nginx conf or systemd, needs to be done manually
echo "delete old copy"
ssh -i ~/labspair.pem ubuntu@labs.dfeldman.org "rm -rfv /home/ubuntu/quokka-quizbot"
echo "copy new copy"
pushd ~/work
tar -cf - quokka-quizbot | ssh -i ~/labspair.pem ubuntu@labs.dfeldman.org "tar -xf - -C /home/ubuntu/"
popd
echo "delete old venv"
ssh -i ~/labspair.pem "rm -rfv /home/ubuntu/quokka-quizbot/.venv"
echo "rebuild venv"
ssh -i ~/labspair.pem ubuntu@labs.dfeldman.org "bash /home/ubuntu/quokka-quizbot/setup.sh"
echo "systemd restart"
ssh -i ~/labspair.pem ubuntu@labs.dfeldman.org "sudo systemctl restart quokka-quizbot"
echo "sleep"
sleep 10
echo "read journal"
ssh -i ~/labspair.pem ubuntu@labs.dfeldman.org "journalctl -u quokka-quizbot"
