<?php

// Install the PHP QR Code library.
require 'vendor/autoload.php';

// Create a new PHP file.
$file = 'qr_code.php';

// In the PHP file, require the QR Code library.
require 'phpqrcode/qrlib.php';

// Create a new QR Code object.
$qrcode = new QRcode();

// Set the data that you want to encode in the QR code.
$data = 'This is a QR code.';

// Set the size of the QR code.
$size = 200;

// Generate the QR code.
$qrcode->setText($data);
$qrcode->setSize($size);
$qrcode->make();

// Output the QR code to the browser.
header('Content-Type: image/png');
echo $qrcode->getImage();

?>
