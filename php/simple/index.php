<?php
require 'vendor/autoload.php';

use Carbon\Carbon;

printf("Right now is %s", Carbon::now()->toDateTimeString());
printf(nl2br("\n"));
printf("Right now in Tokyo is %s", Carbon::now('Asia/Tokyo'));
