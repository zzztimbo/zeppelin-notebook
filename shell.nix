{ pkgs ? import <nixpkgs> {} }:

pkgs.mkShell {
  buildInputs = [
    pkgs.wget
  ];

 shellHook = ''
   if [ ! -d "./spark-3.1.2-bin-hadoop3.2" ]
   then
    echo "downloading spark..."
    wget https://dlcdn.apache.org/spark/spark-3.1.2/spark-3.1.2-bin-hadoop3.2.tgz
    tar -xvf spark-3.1.2-bin-hadoop3.2.tgz
    rm spark-3.1.2-bin-hadoop3.2.tgz
   fi
   spark_location=$PWD/spark-3.1.2-bin-hadoop3.2
   zeppelin_notebook=$PWD/notebooks
   docker run -u$(id -u) -p 8080:8080 -p 4040:4040 --rm -v $spark_location:/opt/spark -v $zeppelin_notebook:/opt/notebook -e ZEPPELIN_NOTEBOOK_DIR=/opt/notebook -e SPARK_HOME=/opt/spark -e ZEPPELIN_LOCAL_IP=0.0.0.0 --name zeppelin apache/zeppelin:0.10.0
 '';
}