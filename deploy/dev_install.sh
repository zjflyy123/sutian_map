# mysql  postgresql redis minio
sudo docker-compose -f database/database-compose.yml --env-file env/.env up -d 

# 后端 制图工具 服务
sudo docker-compose -f backend/maptool-compose.yml --env-file env/.env up -d

# 后端 xtreme_3D 服务
sudo docker-compose -f backend/xtreme3d-compose.yml --env-file env/.env up -d 

# 前端 nginx服务
sudo docker-compose -f frontend/frontend-compose.yml --env-file env/.env up -d
