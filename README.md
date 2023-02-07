# Workshop Instructions

> :warning: 
> Please look out for extra white spaces or character changes when copy pasting code or text.

## Login to Event Engine:

1) Go to https://dashboard.eventengine.run/login
2) Enter your event hash provided by the presenter and click ``“Accept Terms & Login”``
3) Next use Email One-time passcode option to request OTP to your personal or Epsilon email ID.
4) Once logged in click on `”AWS Console”` and then `“Open Console”`
5) Once you see the AWS Console Home, use the `“region”` drop down and select `“us-east-1”` (N. Virginia)
<br>
<br>

## Create VPC:

1) Using the search box at the top of the page, search for `VPC` and click on it.
2) In the VPC Home page, click on `“Create VPC”`
3) In the VPC Creation Wizard, set the following
	-  Name Tag: `Batch`
	-  NAT gateways ($): `“1 per AZ”`
4) Leave everything else as default values and click `“Create VPC”`
5) Creation and activation of NAT gateways takes few minutes. 
6) Wait until VPC is created and click `“View VPC”`
<br>
<br>

## Create S3 Bucket: 

1) Using the search box at the top of the page, search for `S3` and click on it.
2) In the S3 Home page, click on `“Create bucket”`
3) Provide a unique name for the bucket. For example: `aws-batch-`<mark >YOURNAME</mark> (replace <mark >YOURNAME</mark> with your name example: *`aws-batch-sveldi`*)
4) Leave everything else as default values and click `“Create bucket”` at the bottom of the page.
5) Make a note of the bucket name created.
<br>
<br>

## Create IAM Role for ECS Task to Access S3:

1) Using the search box at the top of the page, search for `IAM` and click on it.
2) In the IAM Home page, click on `“Roles”` and then `“Create role”`
3) In the next screen click on `“Use cases for other AWS services”` drop down, search for and select `Elastic Container Service`
4) Now select `“Elastic Container Service Task”` and click `“Next”`
5) In the next screen search for `S3Full` and select the `“AmazonS3FullAccess”` IAM policy and click `“Next”` 
6) Provide the “Role Name” as `aws-batch-ecs-task-s3-access` and click on `“Create role”`
<br>
<br>

## Create Private ECR repositories:

1) Using the search box at the top of the page, search for `ECR` and click on `“Elastic Container Registry”`
2) In the ECR Home page, click on `“Get Started”`
3) Create a repository to hold “single” job container images with the following settings:
	- Visibility settings: `“Private”`
	- Repository Name: `aws-batch-workshop/singlejob`
	- Click `“Create repository”` at the bottom of the page
4) Click on `“Create repository”` to create a second repository to hold “array” job container images with following settings:
	- Visibility settings: `“Private”`
	- Repository Name: `aws-batch-workshop/arrayjob`
	- Click `“Create repository”` at the bottom of the page  

<br>
<br>

> **AWS SDK For Pandas (Data Wrangler)** reference docs: https://aws-sdk-pandas.readthedocs.io/en/stable/index.html

<br>
<br>

## Setup Cloud9 Environment:
1) Using the search box at the top of the page, search for `Cloud9` and click on it.
2) In the Cloud9 Home page, click on `“Create environment”`
3) Set the following settings and click `“Create”`:
    - For Name, enter `MyCloud9Env`
    - Instance type `“m5.large”`
    - Timeout `“1 day”`
4) Once Cloud9 environment is ready, click `“Open”`
<br>
<br>

## Install Pre-reqs & Upload Sample Data 
1) Close default windows in Cloud9 console and launch a new Terminal window
2) Clone the sample code by running `git clone https://github.com/sandeepveldi/aws-batch-samples.git`
3) Goto the sample code directory by running `cd aws-batch-samples`
4) Execute the following commands:
    ```
    chmod +x ./cloud9Setup.sh
    
    ./cloud9Setup.sh
    
    ./s3SampleDataPush.sh
    ```
    The `s3SampleDataPush.sh` script asks for S3 bucket name as input. Key in the bucket name that you created earlier.

<br>
<br>

## Explore the code base
Expand `“aws-batch-samples”` folder on left side and you’ll see the ”arrayJob” and “singleJob” folders which contain their corresponding
- Application code
- Docker file
- Docker build and push to private repo script

## Build and Push Docker images
### Single job:
Execute the following commands in terminal window
```
cd ~/environment/aws-batch-samples/singleJob
./singleJobDockerBuildAndPush.sh
```

### Array job:
Execute the following commands in terminal window
```
cd ~/environment/aws-batch-samples/arrayJob
./arrayJobDockerBuildAndPush.sh
```
