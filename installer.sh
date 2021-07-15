#!/bin/bash
#
####################################### set server php version | composer path

#get variables from "settings.conf" if available- else take laravel / laima config default
######################### template for settings.conf | start
#
#
# #set php version -> if server has many differnt php versions, often default php version is php5.3 but we need at least 7.0
# var_php=php
# #set composer path, if not installed global, we need the current composerversion (download @ composer)
# var_composer='/mnt/1CBD8C4A055CCE33/server/lara_server/composer'
#
#
######################### template for settings.conf | end
FILE=settings.conf
if test -f "$FILE"; then
    source $FILE
else
    #set php version -> if server has many differnt php versions, often default php version is php5.3 but we need at least 7.0
    var_php=php
    #set composer path, if not installed global, we need the current composerversion (download @ composer)
    var_composer='/mnt/1CBD8C4A055CCE33/server/lara_server/composer'
fi

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


folder=$(dirname -- "$PWD")
folder=$folder/$name

#######################################
#
# check if folder exist, if question is true, then delete folder, else abort
#
#######################################
if [ -d $folder/ ];
then
    read -p "
ATTENTION: Folder exist! Should i delete it? (N|y)
" remove_folder

    if [[ ( $remove_folder == "y" ) || ( $remove_folder == "Y" ) || ( $remove_folder == 1 ) ]]
    then
        rm -rf $folder
        echo $folder" deleted"
    else
        echo "ABORT!!!"
        exit 1
    fi
fi



######################################### config_lara_app_prefix | start
read -p "
app prefix:
" config_lara_app_prefix
echo "
--> $config_lara_app_prefix
"
######################################### config_lara_app_prefix | end


######################################### config_lara_admin_prefix | start
read -e -p "admin prefix: " -i "admin" config_lara_admin_prefix
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
read -e -p "Wie lautet die Url? " -i "https://$name.haml" config_url
echo "
--> $config_url
"
######################################### url | end

######################################### config_mysql_host | start
read -e -p "Mysqldaten (Host): " -i "localhost" config_mysql_host
echo "
--> $config_mysql_host
"
######################################### config_mysql_host | end

######################################### config_mysql_user | start
read -e -p "Mysqldaten (User): " -i "root" config_mysql_user
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
read -e -p "Mysqldaten (DB): " -i "$name" config_mysql_db_name
echo "
--> $config_mysql_db_name
"
config_mysql_db_name_test=${config_mysql_db_name}_test
echo " (testdb name)
--> $config_mysql_db_name_test
"
######################################### config_mysql_dn_name | end


######################################### config_lara_multitree | start
read -e -p "multi page tree? (bsp.: /de/seiten || /en/sites): " -i "1" config_lara_multitree
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



#######################################
#
# 1.) ordner erstellen local am webserver
#
#######################################
mkdir $folder/

#install laravel as packagephp
$var_php $var_composer create-project --prefer-dist laravel/laravel:7.29 $folder

echo "
--------------------------------> create env
"

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

PHP_VERSION=$var_php

DB_CONNECTION=mysql
DB_HOST=$config_mysql_host
DB_PORT=3306
DB_DATABASE=$config_mysql_db_name
DB_USERNAME=$config_mysql_user
DB_PASSWORD=$config_mysql_password
DB_STRICT=false

### test installation
DB_TEST_CONNECTION=lara_test
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

COMPOSER_PATH='$var_php $var_composer'

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


## create/overwrite default phpunit.xml

echo '<?xml version="1.0" encoding="UTF-8"?>
<phpunit xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
         xsi:noNamespaceSchemaLocation="./vendor/phpunit/phpunit/phpunit.xsd"
         bootstrap="vendor/autoload.php"
         colors="true"
>
    <testsuites>
        <testsuite name="Engine">
            <directory suffix="EngineTest.php">./vendor/github-haml-eu/lara/src/tests/FeatureEngine</directory>
        </testsuite>
        <testsuite name="Unit">
            <directory suffix="Test.php">./tests/Unit</directory>
        </testsuite>
        <testsuite name="Feature">
            <directory suffix="Test.php">./tests/Feature</directory>
        </testsuite>
    </testsuites>
    <filter>
        <whitelist processUncoveredFilesFromWhitelist="true">
            <directory suffix=".php">./app</directory>
        </whitelist>
    </filter>
    <php>
        <env name="TESTING" value="true"/>
        <server name="APP_ENV" value="testing"/>
        <server name="BCRYPT_ROUNDS" value="4"/>
        <server name="CACHE_DRIVER" value="array"/>
        <server name="DB_CONNECTION" value="lara_test"/>
        <server name="DB_DATABASE" value="test"/>
        <server name="MAIL_MAILER" value="array"/>
        <server name="QUEUE_CONNECTION" value="sync"/>
        <server name="SESSION_DRIVER" value="array"/>
        <server name="TELESCOPE_ENABLED" value="false"/>
    </php>
</phpunit>

' > $folder/phpunit.xml &&


#change dir to folder
cd $folder &&

#you need one valid github token
echo 'how to get a valid github token:
https://docs.github.com/en/github/authenticating-to-github/creating-a-personal-access-token';

#run engine composer install --ignore-platform-reqs
$var_php $var_composer config repositories.github-haml-eu/lara vcs https://github.com/github-haml-eu/lara.git &&
$var_php $var_composer require github-haml-eu/lara:dev-master&&

#remove default usertablecreate migration from laravel
rm $folder/database/migrations/2014_10_12_000000_create_users_table.php &&


##overwrite configs
$var_php artisan vendor:publish --tag engine.auth.config  --force
$var_php artisan vendor:publish --tag engine.app.config  --force
$var_php artisan vendor:publish --tag engine.database.config  --force
$var_php artisan vendor:publish --tag engine.engine.config  --force

echo "
--------------------------------> clear cache
"
#clear cache
$var_php artisan config:cache

echo "
--------------------------------> install
"
##install lara
$var_php artisan lara:install installfull_with_composer_change

##publish vendor (backend files)
$var_php artisan vendor:publish --tag engine.public.css --force
$var_php artisan vendor:publish --tag engine.public.frontend --force
$var_php artisan vendor:publish --tag engine.public.img --force
$var_php artisan vendor:publish --tag engine.public.js --force
$var_php artisan vendor:publish --tag engine.public.plugins --force
$var_php artisan vendor:publish --tag engine.public.vendor --force


##add git ignore logic for backup folders etc..
echo '/storage/backup/*' >> $folder/.gitignore
echo '/storage/lara/*' >> $folder/.gitignore


##testing after installation
$var_php artisan lara:test run_with_new_db 1


#output
echo '

sucessfull installed. happy coding!

'
