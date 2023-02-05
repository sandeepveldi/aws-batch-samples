FROM public.ecr.aws/amazonlinux/amazonlinux:latest 
RUN yum install -y unzip awscli python3 python3-pip
RUN python3 -m pip install boto3 pandas s3fs awswrangler
COPY src /code
ENTRYPOINT [ "python3", "/code/singlejob.py" ]