#!/bin/bash
docker stop assessment2container
docker rm assessment2container
docker rmi --force assessmentcodeimage

mkdir tempdir

cp  assessment_code.py tempdir/.
cp  network_equipment.json tempdir/.

echo "FROM python" >> tempdir/Dockerfile
echo "RUN pip install flask" >> tempdir/Dockerfile
echo "WORKDIR /home/myapp" >> tempdir/Dockerfile
echo "COPY assessment_code.py ." >> tempdir/Dockerfile
echo "COPY network_equipment.json ." >> tempdir/Dockerfile
echo "EXPOSE 5050" >> tempdir/Dockerfile
echo "CMD python /home/myapp/assessment_code.py" >> tempdir/Dockerfile

cd tempdir
docker build -t assessmentcodeimage .
docker run -p 5050:5050 --name assessment2container assessmentcodeimage &
