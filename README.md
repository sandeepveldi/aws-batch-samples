Login to Event Engine:

1) Go to https://dashboard.eventengine.run/login
2) Enter your event hash provided by the presenter and click “Accept Terms & Login”
3) Next use Email One-time passcode option to request OTP to your personal or Epsilon email ID.
4) Once logged in click on ”AWS Console” and then “Open Console”
5) Once you see the AWS Console Home, use the “region” drop down and select “us-east-1” (N. Virginia)

Create VPC:

1) Using the search box at the top of the page, search for VPC and click on it.
2) In the VPC Home page, click on “Create VPC”
3) In the VPC Creation Wizard, set the following
	a) Name Tag: “Batch”
	b) NAT gateways ($): “1 per AZ”
4) Leave everything else as default values and click “Create VPC”
5) Creation of NAT gateways takes few minutes. 
6) Wait until VPC is created and click “View VPC”

Create S3 Bucket: 

1) Using the search box at the top of the page, search for S3 and click on it.
2) In the S3 Home page, click on “Create bucket”
3) Provide a unique name for the bucket. For example: aws-batch-<YOURNAME>
4) Leave everything else as default values and click “Create bucket” at the bottom of the page.
5) Make a note of the bucket name created.

Create IAM Role for ECS Task to Access S3:

1) Using the search box at the top of the page, search for IAM and click on it.
2) In the IAM Home page, click on “Roles” and then “Create role”
3) In the next screen click on “Use cases for other AWS services” drop down, search for and select “Elastic Container Service”
4) Now select “Elastic Container Service Task” and click “Next”
5) In the next screen search for “S3Full” and select the “AmazonS3FullAccess” IAM policy and click “Next” 
6) Provide the “Role Name” as ”aws-batch-ecs-task-s3-access” and click on “Create role”.

Create Private ECR repositories:

1) Using the search box at the top of the page, search for ECR and click on “Elastic Container Registry”.
2) In the ECR Home page, click on “Get Started”
3) Create a repository to hold “single” job container images with the following settings:
	a) Visibility settings: “Private”
	b)Repository Name: “aws-batch-workshop/singlejob”
	c) Click “Create repository” at the bottom of the page
4) Click on “Create repository” to create a second repository to hold “array” job container images with following settings:
	a) Visibility settings: “Private”
	b) Repository Name: “aws-batch-workshop/arrayjob”
	c) Click “Create repository” at the bottom of the page

AWS SDK For Pandas (Data Wrangler) reference docs: https://aws-sdk-pandas.readthedocs.io/en/stable/index.html


Setup Cloud9 Environment:
