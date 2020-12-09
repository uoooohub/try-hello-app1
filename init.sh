service_name=$1
project_name=$2
app_name=$3
App_name=$(echo $app_name | awk '{print toupper(substr($1,1,1))substr($1,2)}')
app_class_name=$4

## docker-compose.ymlと各サービスのDockerfileの構築
sed -e "s/MY_WEB_SERVICE_NAME/${service_name}/g" tmp/docker-compose.yml > docker-compose.yml
sed -e "s/MY_PROJECT_NAME/${site_name}/g" tmp/build/python/Dockerfile > python/Dockerfile
#sed -i -e "s/MY_APP_NAME/${app_name}/g" tmp/build/python/Dockerfile

## build
docker-compose build $service_name .
docker-compose run $service_name django-admin startproject $project_name .

## 各種設定の構築
#sed -e "s/MY_APP_CLASS_NAME/${app_class_name}/g" tmp/build/python/app/models.py > python/app/models.py
#sed -e "s/MY_APP_CLASS_NAME/${app_class_name}/g" tmp/build/python/app/admin.py > python/app/admin.py
#sed -e "s/MY_APP_CLASS_NAME/${app_class_name}/g" tmp/build/python/app/views.py > python/app/views.py
sed -e "s/MY_PROJECT_NAME/${site_name}/g" tmp/build/python/project/settings.py > python/project/settings.py
sed -i -e "s/MY_APP_INSTALLED/${app_name}/g" python/project/settings.py
#sed -e "s/MY_PROJECT_NAME/${site_name}/g" tmp/build/python/project/urls.py > python/project/urls.py
#sed -e "s/MY_APP_NAME/${app_name}/g" tmp/build/python/project/urls.py > python/project/urls.py


docker-compose run $service_name ./manage.py makemigrations
docker-compose run $service_name ./manage.py migrate
#docker-compose run $service_name ./manage.py createsuperuser

docker-compose up