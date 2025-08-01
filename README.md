## 项目名称
高精地图绘制工具（二维+三维）    
二维：基于点云俯视图 + 高程数据，以线、面的形式，绘制道路边界、车道、车道组、车道标识、路口、停止线等交通要素和标志。
三维：基于PCD点云，以三维BOX、三维曲线形式，标注红绿灯、障碍物、杆牌等交通要素。   
技术架构：二维前端 Vue.js + openlayer，三维前端 xtreme1 + Three.js，后端 java，数据库 mysql + postgresql, 缓存 redis。

## 项目说明
> config目录存放数据平台配置：
* maptool -- 二维制图工具配置文件
* xtreme3d -- 三维标注工具配置文件

> deploy目录存放启动安装文件：
* backend -- 二维工具、三维工具的compose文件
* database -- 数据库和minio的compose文件
* env -- 所有环境变量配置的.env文件
* frontend -- 前端的compose文件
* install.sh -- 安装脚本
* uninstall.sh -- 卸载脚本

> frontend目录下存放前端内容：
* conf.d -- 数据平台和制图工具的nginx配置
* maptool -- 二维制图工具前端
* xtreme3d -- 三维标注工具前端

> images_pkg目录下存放二维三维工具对应的镜像：
* maptool.202506.tar -- 二维制图工具镜像
* xtreme3d.202508.tar -- 三维标注工具镜像

> sql_file目录存放数据库初始配置：
* pgsql -- postgres数据库初始化文件，制图工具用
* sql -- mysql数据库初始化文件，数据平台用



## 运行条件
> 软件依赖
* docker
* docker-compose

> 可以修改的配置文件  建议不要修改，防止运行失败
* deploy/env/.env  镜像名、版本号、端口号、配置路径等
* frontend/conf.d/ -- 前端nginx配置文件
* config/ -- 后端配置文件



## 运行说明
> 运行步骤说明
* 1.下载 sutian-map 仓库，修改 deploy/env/.env 中的 APP_FILE_DIR 为项目真实路径
* 2.创建 sutian-data 网络，执行命令：```docker network create sutian-data```
* 3.运行 ```cd sutian-map/deploy/ && ./uninstall.sh && ./install.sh```
* 4.```./uninstall.sh 卸载```

## 注意事项
* 1.权限不足先运行 sudo -s 
* 2.nginx 镜像拉取失败, 手动拉取```docker pull nginx:1.21```, 更改 env 中的  NGINX_IMAGE=nginx:1.21 , 再执行 install.sh 即可
* 3.要让局域网中其他主机访问，wsl 环境中需要配置宿主机端口转发 （[WSL网络配置](http://www.maersi.fun/2025/02/06/docker%E5%AE%89%E8%A3%85/#wsl_%E7%BD%91%E7%BB%9C%E9%85%8D%E7%BD%AE)），VM 环境网络使用 桥接模式
* 4.VMware 共享文件夹时，虚拟机ls查看文件缺失问题，运行 
```sudo vmhgfs-fuse .host:/ /mnt/hgfs -o subtype=vmhgfs-fuse,allow_other```
* 5.报错 Get "https://registry-1.docker.io/v2/": dial tcp 162.125.1.8:443: i/o timeout ，
     添加 [docker 镜像](http://www.maersi.fun/2025/02/06/docker%e5%ae%89%e8%a3%85/#windows_%E5%AE%89%E8%A3%85%E5%8C%85%E5%AE%89%E8%A3%85)  




## 访问地址


> 二维绘图工具
* 访问地址： http://192.168.6.128/?taskId=100001&mapSource=amap  
* 参数说明：  
taskId: 任务id  
zlevel: 点云层级，默认2层  
mapSource: 地图来源， osm：openstreetmap  arcgis：arcgis tianditu：天地图 amap: 高德  



> 三维标注工具
* 访问地址：http://192.168.6.128/xtreme3d/tool/pc/?recordId=79&taskId=100001&lat=31.214687300369448&lng=121.31005928708936  
* 参数说明：   
recordId: 固定值  
taskId: 任务id  
lat lng: 默认位置的经纬度  


> xtreme 管理后台  
* 访问地址：http://192.168.6.128/xtreme3d/  
用户名：admintest@qq.com  
密码： admintest123456  
注意：需要开启 minio 服务， 运行 deploy/minio_restart.sh 即可

> mysql 数据库   
* 默认账号信息  
数据库：x1_community   
用户名：root   
密码：123456   

> postgres 数据库  
* 默认账号信息  
数据库名称：postgres  
用户名：postgres  
密码：postgres  

## 资料说明
核心资料：22级等级下对应的点云、高程数据、瓦片图、PCD文件，以及照片、激光雷达、相机相关参数等。

> 资源存放路径  sutian-map\frontend\maptool\html\100001

* 100001：为任务id, 可自行定义，文件夹下存放当前任务所有的生产资料     
* 100001/automatic_element/: 存放自动标注的要素，第一次打开任务时，先导入这里的文件
* 100001/calib_folder/: 存放激光雷达、相机相关参数
* 100001/camera/: 存放照片数据
* 100001/camera/front/: 存放前视照片
* 100001/camera/rear/: 存放后视照片
* 100001/camera/pos_camera.json: 存放所有采集照片的点位的坐标信息、时间信息、对应的前后视照片名称
* 100001/elv/: 存放高程数据，按 22 级瓦片切割。每个瓦片对一个灰度图 和 json文件, 高程值 = 灰度值 + 基准值
* 100001/result/: 质检通过后导出的结果文件
* 100001/stitchpoint/: 三维标注需要的点云文件，按 22 级瓦片切割的PCD文件。
* 100001/tile/: 二维维制图工具需要的瓦片，又点点云生成的俯视图。按 22 级瓦片切割的png文件。
* 100001/tile/tile.json: 瓦片文件清单，加载到地图时，只加载清单内的文件。

> 补充说明
* pos_camera.json 中第一个点，即为激光雷达的起点。这个在地理坐标与enu坐标转换时会用到。
* 关于 tile elv 概念，参考 点云、pos、高程.pptx
* 使用手册，参考 二维绘图工具-使用手册.docx、二维绘图工具-使用手册.docx


## 视频说明
以下为针对当前系统制作的基础使用教程，视频唯一渠道，哔哩哔哩主页 [CommitLifeV](https://space.bilibili.com/571385576)

> 资源说明  
* [P1：资源及资源服务器说明]()
> 安装部署  
* [P2：安装部署教程-linux]()
* [P3：安装部署教程-windows-VMare]()
* [P4：安装部署教程-windows-WSL]()
> 二维绘图工具使用教程 
* [P5：二维工具介绍]()
* [P5：绘制车道边界 boundary]()
* [P5：绘制车道组 lane_group]()
* [P5：绘制车道中心线 lane]()
* [P5：绘制停止线 stop_line]()
* [P5：绘制车道标识 stop_line]()
* [P5：绘制联通区域 stop_line]()
> 三维绘标注工具教程  
* [P5：三维工具介绍]()
* [P5：二三维联动]()
* [P5：使用三维Box标识物体]()
* [P5：使用三维Line标识物体]()
> 与三方系统集成  
* [P5：与三方集成]()

## 联系方系
* 邮箱：zjf_lyy@163.com
* 微信：youyuniao001   
* 哔哩哔哩主页： [CommitLifeV](https://space.bilibili.com/571385576)  
* gitee项目地址： [sutian_map](https://gitee.com/zjf_lyy/sutian_map)  
* github项目地址： [sutian_map](https://github.com/zjflyy123/sutian_map)  
注：欢迎学习交流，来信请说明来意。