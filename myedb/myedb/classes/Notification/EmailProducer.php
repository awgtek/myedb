<?php
//include_once dirname(__FILE__) .'/../thirdparty/phpMailer/class.phpmailer.php';
//include_once (dirname(__FILE__) .'/../AppLibrary/AppSettings.php');

class EmailProducer
{
	function send_basic_text_email($email_tos, $email_ccs, $email_subject, $email_message)
	{
		//following code adapted from phpMailer 2.2.1 README
		$mail = new PHPMailer();
		if (AppSettings::gv("smtp_server")=="localhost")
		{
			$mail->IsSendmail();
		}	
		else
		{
			$mail->IsSMTP();                                      // set mailer to use SMTP
			$mail->Host = AppSettings::gv("smtp_server");  // specify main and backup server
			$mail->SMTPAuth = true;     // turn on SMTP authentication
			$mail->Username = AppSettings::gv("smtp_user");  // SMTP username
			$mail->Password = AppSettings::gv("smtp_pass"); // SMTP password
		}
		$mail->From = AppSettings::gv("std_email_from");;
		$mail->FromName = "New England Trade";
		foreach($email_tos as $email_to)
		{
			//$mail->AddAddress("josh@example.net", "Josh Adams");
			//$mail->AddAddress("ellen@example.com");                  // name is optional
			$mail->AddAddress($email_to);
			//echo "yo:".$email_to;
		}
		
		foreach($email_ccs as $email_cc)
		{
			$mail->AddCC($email_cc);
		}
		//$mail->AddReplyTo("info@example.com", "Information");
		
		$mail->WordWrap = 50;                                 // set word wrap to 50 characters
		//$mail->AddAttachment("/var/tmp/file.tar.gz");         // add attachments
		//$mail->AddAttachment("/tmp/image.jpg", "new.jpg");    // optional name
		//$mail->IsHTML(true);                                  // set email format to HTML
		
		$mail->Subject = $email_subject;
		$mail->Body    = $email_message;
		//$mail->AltBody = "This is the body in plain text for non-HTML mail clients";
		
		if(!$mail->Send())
		{
		   echo "Message could not be sent. <p>";
		   echo "Mailer Error: " . $mail->ErrorInfo. " ++";
		   echo "<p>Developer note: Maybe the email address is invalid? Please try changing the user email address. <a href='/index.php'>Go back</a> to site.";
		   exit;
		}
		return true;
		//echo "Message has been sent";
	}
}
?>