echo "What's the S3 bucket name"
read s3_bucket_name
aws s3 cp ./sampleData/csv1.csv s3://${s3_bucket_name}/csv-input/
aws s3 cp ./sampleData/csv2.csv s3://${s3_bucket_name}/csv-input/
aws s3 cp ./sampleData/sim-parameters.csv s3://${s3_bucket_name}/input-parameters/