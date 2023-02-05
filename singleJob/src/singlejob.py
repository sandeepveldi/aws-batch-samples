import awswrangler as wr
import pandas as pd
import boto3
import pytz
import os
from datetime import datetime

# Fetch required environment variable values
ce_name = os.getenv('AWS_BATCH_CE_NAME')
jq_name = os.getenv('AWS_BATCH_JQ_NAME')
job_attempt = os.getenv('AWS_BATCH_JOB_ATTEMPT')
job_id = os.getenv('AWS_BATCH_JOB_ID')
input_csv_path = os.getenv('S3_INPUT_CSV_PATH')
output_csv_path = os.getenv('S3_OUTPUT_CSV_PATH')

# Read all input CSV files in chunks of 1 line
dfs = wr.s3.read_csv(path=input_csv_path, chunksize=1)

# Write output CSV files
i=1
for csv_df in dfs:
    output_csv_file_path = output_csv_path + str(i) + '.csv'
    wr.s3.to_csv(
        df=csv_df,
        path=output_csv_file_path,
    )
    i = i + 1

print ("This instance of singleJob executed with JOB_ID: {}, Compute_Environment: {}, Job_Queue: {} in Job_Attempt: {}".format(job_id,ce_name,jq_name,job_attempt))
