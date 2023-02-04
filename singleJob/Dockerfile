FROM public.ecr.aws/amazonlinux/amazonlinux:2 
RUN amazon-linux-extras install epel -y && yum install stress-ng -y 
CMD /usr/bin/stress-ng 
