# LARADOCK CREATOR

※日本語の説明についてはQiitaに掲載してあります。
https://qiita.com/don-bu-rakko/ee0dd2b26eeb232f0d3a

## Overview

You can create Laradock environment on your PC by typing only **ONE** shell command!  
  
If you want to know more each process details, please check below.  
  
(Japanese only) https://qiita.com/don-bu-rakko/items/0297280553e99aa6d7b8  
  
  
## Demo Moive (YouTube)
  
https://www.youtube.com/watch?v=fd1Bazcl8UY  
  
  
## How to use 
  
### Command

If you want to create Laravel project named `sample-app` ...

```shell
git clone https://github.com/cha1ra/laradock-bash.git
cd laradock-bash
bash laradock-creator.sh sample-app
```

You can also choose your project name on process.

```shell
$ bash laradock-creator.sh


++++++++++++++++++++++++++++++
    LARADOCK CREATOR v1.0
Build Laravel env in 10 steps
      by don-bu-rakko
++++++++++++++++++++++++++++++

1. Start Laradock Setup ...

[!] Put your Project Name:
```
  
After that, you will be able to access http://localhost .
  
  
### Validation
  
If directory already exists, you cannnot use this scripts.
  
```shell
~/Sites/bash/laradock-bash master* 7s
❯ bash laradock-creator.sh project-example


++++++++++++++++++++++++++++++
    LARADOCK CREATOR v1.0
Build Laravel env in 10 steps
      by don-bu-rakko
++++++++++++++++++++++++++++++

1. Start Laradock Setup ...

2. Create Project: project-example

3. Make project-example directory

------------ERROR!------------
'project-example' directory already exists!
Stop this operation.
------------------------------
```

If you didin't install docker, it also stop.

```shell
6. Build Docker containers...

------------ERROR!------------
Docker doesn't exist on your computer! Please install Docker first
Stop this operation.
------------------------------
```
  
  
## Environment
  
- Mac OS 10.14
- Git installed
- Docker for mac installed

## Container
- nginx
- mysql
- phpmyadmin
