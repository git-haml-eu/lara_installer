<?php
#################################
#
# custom cronjob logic for server like easyname - which have a limitation to min. 5 minuten cronjob
#
# how to: make 60 cronjobs that trigger this script. this script will manage all cronjobs
#
#################################
$file_handle = fopen(dirname(__FILE__)."/settings.conf", "rb");

while (!feof($file_handle) ) {
    $line_of_text = fgets($file_handle);
    $data = explode('=', $line_of_text);
    if(array_key_exists(1,$data)){
        $parts[$data[0]] = $data[1];
    }
}

fclose($file_handle);


$php = trim($parts['var_php']);
$composer = trim($parts['var_composer']);
$cronjobs = explode(',',trim($parts['cronjobs']));


//run different cronjobs
foreach($cronjobs as $cronjobpath){
    $run[$cronjobpath] = system($php." ".$cronjobpath."/artisan schedule:run");
}
?>
