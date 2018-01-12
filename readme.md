# docker-parquet-mr

Building Apache Parquet with Docker.

# Motivation

I wanted to build jars for `parquet-cli` and `parquet-tools` on Gentoo.

The upstream documentation is
[wrong](https://github.com/apache/parquet-mr/pull/438) and is also Debian
specific.

# Usage

Building the jars:

```bash
george@george:~$ docker build -t parquet-mr docker-parquet-mr
george@george:~$ docker run -d --name parquet-mr parquet-mr sleep 3600
george@george:~$ docker cp parquet-mr:/parquet-mr/parquet-cli/target/parquet-cli-1.9.1-SNAPSHOT-runtime.jar ./
george@george:~$ docker cp parquet-mr:/parquet-mr/parquet-tools/target/parquet-tools-1.9.1-SNAPSHOT.jar ./
```

Using the jars:

```
java -jar parquet-cli-1.9.1-SNAPSHOT-runtime.jar org.apache.parquet.cli.Main
hadoop jar parquet-cli-1.9.1-SNAPSHOT-runtime.jar org.apache.parquet.cli.Main
```
