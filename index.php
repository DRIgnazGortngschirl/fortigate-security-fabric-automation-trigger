<?php
//whether ip is from share internet
if (!empty($_SERVER['HTTP_CLIENT_IP'])) {
  $IP_ADDRESS = $_SERVER['HTTP_CLIENT_IP'];
}
//whether ip is from proxy
elseif (!empty($_SERVER['HTTP_X_FORWARDED_FOR'])) {
  $IP_ADDRESS = $_SERVER['HTTP_X_FORWARDED_FOR'];
}
//whether ip is from remote address
else {
  $IP_ADDRESS = $_SERVER['REMOTE_ADDR'];
}
$DATA = $_GET['DATA'];
$FP = fopen("INPUT-$IP_ADDRESS", "a");
$SAVE = $DATA . "\n";
fwrite($FP, $SAVE);
fclose($FP);

shell_exec("./run.sh $IP_ADDRESS");
echo ("<h1>OK</h1>");
echo $IP_ADDRESS;