echo "Installing AWS CLI V2"
curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
unzip awscliv2.zip
sudo ./aws/install -i /usr/local/aws-cli -b /usr/bin
aws --version

echo "Installing jq"
sudo yum -y install jq 

echo "Setup AWS CLI to use current AWS region"
export AWS_REGION=$(curl --silent http://169.254.169.254/latest/meta-data/placement/region)
aws configure set default.region ${AWS_REGION}
aws configure get default.region

echo "Resize AWS Cloud9 root Volume"
curl -s "https://gist.githubusercontent.com/wongcyrus/a4e726b961260395efa7811cab0b4516/raw/6a045f51acb2338bb2149024a28621db2abfcaab/resize.sh" | bash /dev/stdin 20

echo "Installing Docker"
sudo amazon-linux-extras install docker

echo "Starting Docker Service"
sudo service docker start

echo "Ensure Docker Service started"
docker info

echo "Grant executable permissions to scripts"

chmod +x ./singleJob/singleJobDockerBuildAndPush.sh ./arrayJob/arrayJobDockerBuildAndPush.sh


rm -f ./awscliv2.zip