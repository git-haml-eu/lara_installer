#!/bin/bash


#######################################
#
# get name
#
#######################################

read -p "
Welches Projekt soll generiert werden?
" name
echo "
--> $name
"





######################################### config_lara_app_prefix | start
read -p "
app prefix: 
" config_lara_app_prefix
echo "
--> $config_lara_app_prefix
"
######################################### config_lara_app_prefix | end


######################################### config_lara_admin_prefix | start
read -p "
admin prefix: 
" config_lara_admin_prefix
echo "
--> $config_lara_admin_prefix
"
######################################### config_lara_admin_prefix | end


######################################### config_lara_api_prefix | start
read -p "
api prefix: 
" config_lara_api_prefix
echo "
--> $config_lara_api_prefix
"
######################################### config_lara_api_prefix | end


######################################### config_lara_frontend_prefix | start
read -p "
frontend prefix: 
" config_lara_frontend_prefix
echo "
--> $config_lara_frontend_prefix
"
######################################### config_lara_frontend_prefix | end








######################################### url | start
read -p "
Wie lautet die Url: 
(bsp.: https://engine.haml)
" config_url
echo "
--> $config_url
"
######################################### url | end

######################################### config_mysql_host | start
read -p "
Mysqldaten (Host): 
" config_mysql_host
echo "
--> $config_mysql_host
"
######################################### config_mysql_host | end

######################################### config_mysql_user | start
read -p "
Mysqldaten (User): 
" config_mysql_user
echo "
--> $config_mysql_user
"
######################################### config_mysql_user | end


######################################### config_mysql_password | start
read -p "
Mysqldaten (Password): 
" config_mysql_password
echo "
--> $config_mysql_password
"
######################################### config_mconfig_mysql_passwordysql_user | end


######################################### config_mysql_dn_name | start
read -p "
Mysqldaten (DB): 
" config_mysql_db_name
echo "
--> $config_mysql_db_name
"
######################################### config_mysql_dn_name | end


######################################### config_lara_multitree | start
read -p "
Multipagetree?: 
" config_lara_multitree
echo "
--> $config_lara_multitree
"
######################################### config_lara_multitree | end




######################################### config_email_from_name | start
read -p "
email (sender name): 
" config_email_from_name
echo "
--> $config_email_from_name
"
######################################### config_email_from_name | end

######################################### config_email_from_email | start
read -p "
email (sender email): 
" config_email_from_email
echo "
--> $config_email_from_email
"
######################################### config_email_from_email | end

######################################### config_email_driver | start
read -p "
email (mail driver: smtp | sendmail): 
" config_email_driver
echo "
--> $config_email_driver
"
######################################### config_email_driver | end


######################################### config_email_host | start
read -p "
email (host): 
" config_email_host
echo "
--> $config_email_host
"
######################################### config_email_host | end

######################################### config_email_port | start
read -p "
email (port): 
" config_email_port
echo "
--> $config_email_port
"
######################################### config_email_port | end


######################################### config_email_password | start
read -p "
email (password): 
" config_email_password
echo "
--> $config_email_password
"
######################################### config_email_password | end

######################################### config_email_encryption | start
read -p "
email (encryption): 
" config_email_encryption
echo "
--> $config_email_encryption
"
######################################### config_email_encryption | end



#######################################
#
# set variables
#
#######################################

folder=$PWD/$name

#######################################
#
# check for duplicates
#
#######################################


if [ -d $folder/ ];
then
echo "
folder exist!!! abort! 
"
exit 1
fi


#######################################
#
# 1.) ordner erstellen local am webserver
#
#######################################
mkdir $folder/

#install laravel as packagephp 
composer create-project --prefer-dist laravel/laravel $name 


echo "
APP_ENV=local
APP_DEBUG=true

APP_NAME=$name
APP_URL=$config_url


APP_MULTI_PAGE_TREE=$config_lara_multitree

APP_APP_PREFIX=$config_lara_app_prefix
APP_ADMIN_PREFIX=$config_lara_admin_prefix
APP_API_PREFIX=$config_lara_api_prefix
APP_FRONTEND_PREFIX=$config_lara_frontend_prefix


DB_CONNECTION=mysql
DB_HOST=$config_mysql_host
DB_PORT=3306
DB_DATABASE=$config_mysql_db_name
DB_USERNAME=$config_mysql_user
DB_PASSWORD=$config_mysql_password
DB_STRICT=false

### test installation
DB_TEST_CONNECTION=test
DB_TEST_HOST=$config_mysql_host
DB_TEST_PORT=3306
DB_TEST_DATABASE=$config_mysql_db_name_test
DB_TEST_USERNAME=$config_mysql_user
DB_TEST_PASSWORD=$config_mysql_password
DB_TEST_STRICT=false

MAIL_FROM_NAME=$config_email_from_name
MAIL_FROM_ADDRESS=$config_email_from_email
#MAIL_DRIVER=smtp
MAIL_DRIVER=$config_email_driver
MAIL_HOST=$config_email_host
MAIL_PORT=$config_email_port
MAIL_USERNAME=$config_email_from_email
MAIL_PASSWORD=$config_email_password
MAIL_ENCRYPTION=$config_email_encryption

### security
ENCRYPT=A,B,C,D,E,F,G,H,I,J,K,L,M,N,O,P,Q,R,S,T,U,V,W,X,Y,Z,a,b,c,d,e,f,g,h,i,j,k,l,m,n,o,p,q,r,s,t,u,v,w,x,y,z,1,2,3,4,5,6,7,8,9,0,!,,,.,-,/,?
DECRYPT=E,X,N,C,K,O,R,Y,I,A,G,P,H,B,D,F,J,U,Z,Q,L,W,M,V,T,S,c,f,b,d,h,q,v,z,k,m,o,a,g,p,n,r,e,j,w,i,y,u,x,l,t,s,-,8,4,9,1,,,!,0,5,.,6,3,7,2,{,}

APP_PATCH_PASSWORD=SecurePatchPassword!

FACEBOOK_KEY=
GOOGLE_MAPS_KEY=
GOOGLE_PLACE_KEY=

#########################################

APP_KEY=base64:B2UPTHFjbJtPEPOG7jgnNZpZf+mB94YuPtBEI3kyz1s=

LOG_CHANNEL=stack

BROADCAST_DRIVER=log
CACHE_DRIVER=file
QUEUE_CONNECTION=sync
SESSION_DRIVER=file
SESSION_LIFETIME=120

REDIS_HOST=127.0.0.1
REDIS_PASSWORD=null
REDIS_PORT=6379


AWS_ACCESS_KEY_ID=
AWS_SECRET_ACCESS_KEY=
AWS_DEFAULT_REGION=us-east-1
AWS_BUCKET=

PUSHER_APP_ID=
PUSHER_APP_KEY=
PUSHER_APP_SECRET=
PUSHER_APP_CLUSTER=mt1

MIX_PUSHER_APP_KEY="${PUSHER_APP_KEY}"
MIX_PUSHER_APP_CLUSTER="${PUSHER_APP_CLUSTER}"  
" > $folder/.env && 

#change dir to folder
cd $folder &&

#run engine
composer config repositories.git-haml-eu vcs https://github.com/git-haml-eu/lara.git && 
composer require git-haml-eu/lara:dev-master && 

#remove default usertablecreate migration from laravel
rm $folder/database/migrations/2014_10_12_000000_create_users_table.php && 

#replace phpunit
cp $folder/vendor/git-haml-eu/lara/src/phpunit.xml.example $folder/phpunit.xml && 

nano $folder/phpunit.xml 

php artisan lara:install installfull

#output
echo '

sucessfull installed. happy coding!

'