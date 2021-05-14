# OpenROAD-flow-in-Local-faster-way

## 一、简介及环境

一键搭建OpenROAD-flow所需环境

搭建需求如下：

系统

* Ubuntu20.04LTS（Aliyun—ECS with 2h4G）
* or Ubuntu20.04LTS（VMware虚拟机 2h2G）

## 二、搭建步骤

### 获取本项目

```shell

git clone https://github.com/dawnli-github/OpenROAD-flow-in-Local-faster-way.git
cd OpenROAD-flow-in-Local-faster-way
mv build.sh your_path

```

__your_path，即建议build.sh文件位置:__
* /root/:如果你为root用户
* /home/username/:如果你为普通用户 

因为本脚本将创建download文件夹放置必要的环境以及创建workspace文件夹用于放置OpenROAD-flow主程序文件

### 执行脚本

```shell

source build.sh

```