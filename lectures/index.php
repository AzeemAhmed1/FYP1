<?php require 'config/config.php'; ?>
<html>
<head>
<title>Video</title>

</head>

<body>
<?php
	if(isset($_POST['UploadVideo']))
	{
		$my_Video= $_FILES['my_video']['name'];
		$my_VideoTmpName=$_FILES['my_video']['tmp_name'];
		
		$newFileName = substr($my_Video,0,(strrpos($my_Video,".")));
		$uploadFolder = "video/".$my_Video;
		
		move_uploaded_file($my_VideoTmpName,$uploadFolder);
		$upload = $conn -> query("INSERT INTO videolectures(video_url,video_name)VALUES('$my_Video','$newFileName')");
		if($upload)
		{
			echo "Uploaded Successfully";
		}else{
			echo "Upload Failed".mysqli_error($conn);
		}
	}
?>
    <form id="upload_form" action="" method="POST" enctype="multipart/form-data">
        <h3>upload your video</h3>
		<div>
			<input style="background-color: gray; width: 200px" type="file" id="my_video" name="my_video" required="">
			<button type="submit" id="UploadVideo" style="width: 200px;" name="UploadVideo">
				Upload Video
			
			</button>
		</div>
    </form>
</body>
</html>