# Workshop Instructions

> :warning: 
> Please look out for extra white spaces or character changes when copy pasting code or text. I've tried not to include double quotes (`" "`) in the text that's supposed to be copied. But please be on the look out.

## Login to Event Engine:

1) Go to https://dashboard.eventengine.run/login
2) Enter your event hash provided by the presenter and click ``“Accept Terms & Login”``
3) Next use Email One-time passcode option to request OTP to your personal or Epsilon email ID.
4) Once logged in click on `”AWS Console”` and then `“Open Console”`
5) Once you see the AWS Console Home, use the `“region”` drop down and select `“US East (N. Virginia) us-east-1”` 

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

## Create S3 Bucket: 

1) Using the search box at the top of the page, search for `S3` and click on it.
2) In the S3 Home page, click on `“Create bucket”`
3) Provide a unique name for the bucket. For example: `aws-batch-`<mark >YOURNAME</mark> (replace <mark >YOURNAME</mark> with your name example: *`aws-batch-sveldi`*)
4) Leave everything else as default values and click `“Create bucket”` at the bottom of the page.
5) Make a note of the bucket name created.
<br>

## Create IAM Role for ECS Task to Access S3:

1) Using the search box at the top of the page, search for `IAM` and click on it.
2) In the IAM Home page, click on `“Roles”` and then `“Create role”`
3) In the next screen click on `“Use cases for other AWS services”` drop down, search for and select `Elastic Container Service`
4) Now select `“Elastic Container Service Task”` and click `“Next”`
5) In the next screen search for `S3Full` and select the `“AmazonS3FullAccess”` IAM policy and click `“Next”` 
6) Provide the “Role Name” as `aws-batch-ecs-task-s3-access` and click on `“Create role”`
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

> **AWS SDK For Pandas (Data Wrangler)** reference docs: https://aws-sdk-pandas.readthedocs.io/en/stable/index.html

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

## Install Pre-reqs & Upload Sample Data: 
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

## Explore the code base:
Expand `“aws-batch-samples”` folder on left side and you’ll see the ”arrayJob” and “singleJob” folders which contain their corresponding
- Application code
- Docker file
- Docker build and push to private repo script

## Build and Push Docker images:
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
<br>

## Fetch container images URIs:

### Amazon ECR Console:
1) In the same browser where you have Cloud9 opened, open a new tab and go to `console.aws.amazon.com/ecr`
2) Click on `“Repositories”` on the left side.
3) You will see the URIs for the `“arrayjob”` and the `“singlejob”`. Make a note of both the URIs in a text file. We will use them when creating AWS Batch Job Definitions later. 

<br>

## Create OnDemand CE:

### AWS Batch Console:
1) In the same browser, open a new tab and go to `console.aws.amazon.com/batch`
2) Click on `“Compute environments”` on the left side.

### Create OnDemand CE:
1) Click on “Compute environments” on the left side.
2) Click “`Create”`
3) Select `“Compute environment configuration”` as `“Amazon Elastic Compute Cloud (Amazon EC2)”` and click `“Confirm”` when asked for confirmation to change platform.
4) Provide `ondemand-ce` as the `“Name”`
5) For the `“Instance role”`, select `“Create new role”` and click `“Next page”` at the bottom of the screen.
6) Leave the `default` values for `CPUs` and `”Allowed Instance Types”` and click `“Next page”`
7) In the `“Virtual Private Cloud (VPC) ID”` drop down, choose the `“Batch-vpc”` that we created earlier and for the subnets select the ones that say `“private”` in their name.
8) Click `“Next Page”` and then `“Create compute environment”` in the next page

<br> 

## Create Spot CE:
1) Click on `“Compute environments”` on the left side.
2) Click `“Create”`
3) Select `“Compute environment configuration”` as `“Amazon Elastic Compute Cloud (Amazon EC2)”` and click `“Confirm”` when asked for confirmation to change platform.
4) Provide `spot-ce` as the `“Name”`
5) For the `“Instance role”`, select `“ecsInstanceRole”` click `“Next page”` at the bottom of the screen.
6) Toggle the switch that says `“Enable using Spot instances”`
7) Set the `“Maximum vCPUs”` as `512` and click `“Next page”`
8) In the `“Virtual Private Cloud (VPC) ID”` drop down, choose the `“Batch-vpc”` that we created earlier and for the subnets select the ones that say `“private”` in their name.
9) Click `“Next Page”` and then `“Create compute environment”` in the next page

<br>

## Create Job Queue:
1) Click on `“Job queues”` on the left side.
2) Click `“Create”`
3) Select `“Orchestration type”` as `“Amazon Elastic Compute Cloud (Amazon EC2)”`
4) Provide `jq1` as the `“Name”`
5) Select both `“ondemand-ce”` and `“spot-ce”` under `“Connected compute envrionments”`
6) Ensure `“ondemand-ce”` is `“1”` and `“spot-ce”` is `“2”` in the `“Compute environment order”`
7) Click on `“Create job queue”`

<br>

## Create “Single” job definition:
1) Click on `“Job definitions”` on the left side.
2) Click `“Create”`
3) Select `“Orchestration type”` as `“Amazon Elastic Compute Cloud (Amazon EC2)”` and click `“Confirm”` when asked for confirmation to change platform.
4) Provide `singlejob` as the `“Name”` and click on `“Next page”`
5) Replace `“public.ecr.aws/amazonlinux/amazonlinux”` portion of the `“Image”` information with the “`Simple job”` ECR container images URI that you’ve noted previously. **DONOT REMOVE THE** `:latest` portion of the image information.
6) Clear the default command in the `“Command”` text box.
7) Set the `“Job role configuration`” to `“aws-batch-ecs-task-s3-access”` IAM role that was created in one of the previous steps.
8) Under the `“Environment configuration”`, set the `“vCPUs”` to `2` and `“Memory”` to `4096`
9) Add the following `“Environment variables”` 

    > NOTE: Replace `<NAME_OF_S3_BUCKET>` with the S3 bucket name that you created in one of the earlier steps.

    - Name - `S3_INPUT_CSV_PATH` and Value - `s3://<NAME_OF_S3_BUCKET>/csv-input/`
    - Name - `S3_OUTPUT_CSV_PATH` and Value - `s3://<NAME_OF_S3_BUCKET>/csv-output/`
  
10) Click on `“Next page”`
11) Under `“Log driver”` select `“awslogs”` and click `“Next page”` and `“Create job definition”`

<br>

## Create “Array” job definition: 
1) Click on `“Job definitions”` on the left side.
2) Click `“Create”`
3) Select `“Orchestration type”` as `“Amazon Elastic Compute Cloud (Amazon EC2)”` and click `“Confirm”` when asked for confirmation to change platform.
4) Provide `arrayjob` as the `“Name”` and click on `“Next page”`
5) Replace `“public.ecr.aws/amazonlinux/amazonlinux”` portion of the `“Image”` information with the `“Array job”` ECR container images URI that you’ve noted previously. **DONOT REMOVE THE** `:latest` portion of the image information.
6) Clear the default command in the `“Command”` text box.
7) Set the `“Job role configuration”` to `“aws-batch-ecs-task-s3-access”` IAM role that was created in one of the previous steps.
8) Under the `“Environment configuration”`, set the `“vCPUs”` to `2` and `“Memory”` to `4096`
9) Add the following `“Environment variables”`
    
    > NOTE: Replace `<NAME_OF_S3_BUCKET>` with the S3 bucket name that you created in one of the earlier steps.

    - Name -  `S3_INPUT_CSV_PATH` and Value - `s3://<NAME_OF_S3_BUCKET>/csv-input/`
    - Name - `S3_OUTPUT_CSV_PATH` and Value - `s3://<NAME_OF_S3_BUCKET>/csv-output/`
    - Name - `S3_INPUT_PARAM_FILE_URL` and Value - `s3://<NAME_OF_S3_BUCKET>/input-parameters/sim-parameters.csv`
  
10) Click on “Next page”
11) Under “Log driver” select “awslogs” and click “Next page” and “Create job definition”

<br>

## Submit “Single” job:
1) Click on `“Jobs”` on the left side.
2) Click `“Submit new job”`
3) Provide `single-job-1` as the `“Name”`, `“singlejob”` under `“Job definition”` and `“jq1”` under `“Job queue”` and click `“Next page”` and `“Next page”` again.
4) Click on `“Create job”`.
5) Observe the job goes through various job statuses. You can click on the refresh button to check latest status. The job completion takes a few minutes. 
6) Once the job status changes to either `“SUCCEDED”` or `“FAILED”`, you’ll be able to see the logs by opening the CloudWatch log stream available under `“Log stream name”`.
7) Notice the details captured in the log entry.

<br>

## Submit “Array” job:
1) Head back to the “`AWS Batch”` console page to submit an `“Array”` job.
2) Click on `“Jobs”`.
3) Click `“Submit new job”`
4) Provide `array-job-1` as the `“Name”`, `“arrayjob”` under `“Job definition”`, `“jq1”` under `“Job queue`”, `12` under `“Array size”` and click `“Next page”` and `“Next page”` again.
5) Click on `“Create job”`.
6) Observe the individual job indexes (simulations) go through various job statuses. You can click on the refresh button to check latest status. The jobs completion takes a few minutes. 
7) Once the job status changes to either `“SUCCEDED”` or `“FAILED”`, you’ll be able to see the logs by opening the CloudWatch log stream available under `“Log stream name”` under job index specific pages.
8) Notice the details captured in the log entry especially the `”Simulation_Parameters”`.

## S3 Outputs:
1) In the search box at the top of the page, key in `S3`.
2) Click on `“S3”`.
3) Goto the S3 bucket that you created earlier and look at the contents of the `“csv-output/”` folder.
4) The individual .csv files that you see under this folder are generated by the `“Single”` job and the month based folders and the .csv files in them are created by the `“Array”` job which considers Month name as an input parameter.


:clap::skin-tone-4: