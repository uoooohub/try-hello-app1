service_name=$1
project_name=$2
app_name=$3
App_name=$(echo $app_name | awk '{print toupper(substr($1,1,1))substr($1,2)}')

## docker-compose.ymlと各サービスのDockerfileの構築
sed -e "s/MY_WEB_SERVICE_NAME/${service_name}/g" tmp/docker-compose.yml > docker-compose.yml
sed -e "s/MY_PROJECT_NAME/${project_name}/g" tmp/build/python/Dockerfile > python/Dockerfile
sed -i -e "s/MY_APP_NAME/${app_name}/g" python/Dockerfile

## build
docker-compose run $service_name django-admin startproject $project_name .
docker-compose run $service_name ./manage.py startapp $app_name

## 各種projectとappのファイルや設定の構築
sed -e "s/MY_PROJECT_NAME/${project_name}/g" tmp/build/python/project/settings.py > src/$project_name/settings.py
sed -i -e "s/MY_APP_NAME/${app_name}/g" src/$project_name/settings.py
sed -i -e "s/MY_APP_INSTALLED/${app_name}/g" src/$project_name/settings.py
sed -e "s/MY_PROJECT_NAME/${project_name}/g" tmp/build/python/project/urls.py > src/$project_name/urls.py
sed -i -e "s/MY_APP_NAME/${app_name}/g" src/$project_name/urls.py

cp tmp/build/python/app/models.py src/$app_name/models.py
cp tmp/build/python/app/admin.py src/$app_name/admin.py
cp tmp/build/python/app/views.py src/$app_name/views.py
cp tmp/build/python/app/forms.py src/$app_name/forms.py

sed -e "s/MY_PROJECT_NAME/${project_name}/g" tmp/build/python/app/urls.py > src/$app_name/urls.py
sed -i -e "s/MY_APP_NAME/${app_name}/g" src/$app_name/urls.py

cp -r tmp/build/python/app/templates src/$app_name/templates
cp -r tmp/build/python/app/templatetags src/$app_name/templatetags

# migrate
docker-compose run $service_name ./manage.py makemigrations
docker-compose run $service_name ./manage.py migrate

# create admin
#docker-compose run $service_name ./manage.py createsuperuser

docker-compose up