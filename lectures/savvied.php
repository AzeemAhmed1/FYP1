<?php
require 'config/config.php';
$myVideo= $_FILES['my_video']['name'];
$my_VideoTmpName=$_FILES['my_video']['tmp_name'];
		
$newFileName = substr($myVideo,0,(strrpos($myVideo,".")));
$uploadFolder = "video/".$myVideo;
		
move_uploaded_file($my_VideoTmpName,$uploadFolder);
$upload = $conn -> query("INSERT INTO videolectures(video_url,video_name)VALUES('$myVideo','$newFileName')");
if($upload)
{
	echo json_encode("Uploaded Successfully");
}else{
	echo json_encode("Upload Failed".mysqli_error($conn));
}
?>