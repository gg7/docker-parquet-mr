# docker-parquet-mr

Building Apache Parquet with Docker.

# Motivation

I wanted to build jars for `parquet-cli` and `parquet-tools` on Gentoo.

The upstream documentation is
[wrong](https://github.com/apache/parquet-mr/pull/438) and is also Debian
specific.

# Building the jars

```bash
george@george:~/docker-parquet-mr$ docker build -t parquet-mr .
```

You can also pass `--build-arg PROTOBUF_VERSION 3.2.0` and/or
`--build-arg THRIFT_VERSION 0.9.3` if you prefer other versions.

Extracting the jars:

```
george@george:~$ docker run -d --name parquet-mr parquet-mr sleep 3600
george@george:~$ docker cp parquet-mr:/parquet-mr/parquet-cli/target/parquet-cli-1.10.1-SNAPSHOT-runtime.jar ./
george@george:~$ docker cp parquet-mr:/parquet-mr/parquet-tools/target/parquet-tools-1.10.1-SNAPSHOT.jar ./
george@george:~$ docker rm -f parquet-mr
```

# Using parquet-tools

```
george@george:~$ java -jar parquet-tools-1.10.1-SNAPSHOT.jar --help
george@george:~$ java -jar parquet-tools-1.10.1-SNAPSHOT.jar schema 'local-file.parquet'
george@george:~$ hadoop-3.1.0/bin/hadoop jar parquet-tools-1.10.1-SNAPSHOT.jar schema 'hdfs://server/remote-file.parquet'
```

# Using parquet-cli

```
george@george:~$ hadoop-3.1.0/bin/hadoop jar parquet-cli-1.10.1-SNAPSHOT-runtime.jar org.apache.parquet.cli.Main --help
george@george:~$ hadoop-3.1.0/bin/hadoop jar parquet-cli-1.10.1-SNAPSHOT-runtime.jar org.apache.parquet.cli.Main schema 'local-file.parquet'
george@george:~$ hadoop-3.1.0/bin/hadoop jar parquet-cli-1.10.1-SNAPSHOT-runtime.jar org.apache.parquet.cli.Main schema 'hdfs://server/remote-file.parquet'
```
