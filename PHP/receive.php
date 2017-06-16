<?php
$data = file_get_contents('php://input');
$plistBegin   = '<?xml version="1.0"';
$plistEnd   = '</plist>';
$pos1 = strpos($data, $plistBegin);
$pos2 = strpos($data, $plistEnd);
$data2 = substr ($data,$pos1,$pos2-$pos1);
$xml = xml_parser_create();
xml_parse_into_struct($xml, $data2, $vs);
xml_parser_free($xml);

$UDID = "";

$CHALLENGE = "";

$DEVICE_NAME = "";

$DEVICE_PRODUCT = "";

$DEVICE_VERSION = "";

$iterator = 0;

$arrayCleaned = array();
foreach($vs as $v){
    if($v['level'] == 3 && $v['type'] == 'complete'){

    $arrayCleaned[]= $v;

    }
$iterator++;

}

$data = "";
$iterator = 0;

foreach($arrayCleaned as $elem){

    $data .= "\n==".$elem['tag']." -> ".$elem['value']."<br/>";

    switch ($elem['value']) {

        case "CHALLENGE":

            $CHALLENGE = $arrayCleaned[$iterator+1]['value'];

            break;

        case "DEVICE_NAME":

            $DEVICE_NAME = $arrayCleaned[$iterator+1]['value'];

            break;

        case "PRODUCT":

            $DEVICE_PRODUCT = $arrayCleaned[$iterator+1]['value'];

            break;

        case "UDID":

            $UDID = $arrayCleaned[$iterator+1]['value'];

            break;

        case "VERSION":

            $DEVICE_VERSION = $arrayCleaned[$iterator+1]['value'];

            break;                       

        }
        $iterator++;

}

 

$params = "UDID=".$UDID."&CHALLENGE=".$CHALLENGE."&DEVICE_NAME=".$DEVICE_NAME."&DEVICE_PR ODUCT=".$DEVICE_PRODUCT."&DEVICE_VERSION=".$DEVICE_VERSION;

//header("Location: http://dev.skyfox.org/udid?data=".rawurlencode($params));
header('HTTP/1.1 301 Moved Permanently');
header("Location: http://dev.skyfox.org/udid/index.php?".$params);
?>