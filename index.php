<?php
// echo "test print";exit;// Test for commit.

define( '_PPSK_IS_CIPHER', FALSE );//	TRUE FALSE
require_once( 'inc.php' );

try{
	$auth_obj	= new Authentication();			//	This command is necessary to init session.  statusMessages

	$db_conn	= new DbConnect( $host, $db_name, $db_user, $user_pass );
	$db_conn->doConnect();

	$gl_Xajax = new xajax();
 	$gl_Xajax->configure('debug', FALSE );
 	$gl_Xajax->configure('javascript URI', _XAJAX_JS_DIR );
 	$act_obj	= new ajaxActions();	//	This object is created to start constructor where ajax handlers are initialized
 	$js_xajax	= $gl_Xajax->getJavascript( _XAJAX_JS_DIR, NULL );

	$app		= new RunApp();
	$contents	= $app->getHtmlView();
}catch( Exception $e ){
	Log::_log( $e->getMessage(), 'Error' );
	exit;
}

$page_contet	=
'<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.1 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd" />'.
'<html xmlns="http://www.w3.org/1999/xhtml" />'.
'<head>'.
'<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />'.
'<title>'._CONTAINER.' '._CONTAINER_N.'</title>'.


'<link rel="stylesheet" href="css/main.css" type="text/css" />'.
'<link rel="stylesheet" href="libs/ppsk/ppsk.css" type="text/css" />'.
'<link rel="stylesheet" href="js/slides/slides.css" type="text/css" />'.
'<link rel="stylesheet" href="css/general.css" type="text/css" />'.
'<link rel="stylesheet" href="'.$gl_CompsPath.'css/components.css" type="text/css" />'.
//IMPORTANT. This file must be last one.
'<link rel="stylesheet" href="css/opera.css" type="opera/css" media="screen" />'.

'<script src="./js/jQuery/jquery-1.9.1.js"></script>'.
'<script src="./js/jQuery/upload/vendor/jquery.ui.widget.js"></script>'.
'<script src="./js/jQuery/upload/jquery.iframe-transport.js"></script>'.
'<script src="./js/jQuery/upload/jquery.fileupload.js"></script>'.


$js_xajax.iniJsEnvironment().
'<script type="text/javascript" src="js/main.js"></script>'.
'<script type="text/javascript" src="js/scroller/jsScroller.js"></script>'.
'<script type="text/javascript" src="js/scroller/jsScrollbar.js"></script>'.
'<script type="text/javascript" src="js/slides/slides.js"></script>'.
'<script type="text/javascript" src="js/run_txt/run_txt.js"></script>'.
'<script type="text/javascript" src="libs/ppsk/ppsk.js"></script>'.


'</head>'.

'<body id="body_id">'.
'<center>'.
'<div class="mainContainer">'.

	'<div class="headerDiv">'.
	'<table class="headerTable" cellpadding="0" cellspacing="0">'.
		'<tr>'.
			'<td class="logoTd">'.
			'<table class="logoTable" cellpadding="0" cellspacing="0">'.
				'<tr><td class="logoNameCnt">'.mb_strtoupper( _CONTAINER, 'UTF-8' ).'<br />'._CONTAINER_N.'</td></tr>'.
				'<tr><td class="logoName">'.mb_strtoupper( _OWNER_NAME, 'UTF-8' ).'</td></tr>'.
			'</table>'.
			'</td>'.

			'<td class="headerInfoTd">'.
			'<table class="infoTable" cellpadding="0" cellspacing="0">'.
				'<tr><td class="businessName" colspan="2">'._BUSINESS_NAME.'</td></tr>'.
				'<tr><td class="businessStatus">'._BUSINESS_STATUS.'</td><td class="placeName">'._PLACE_NAME.'</td></tr>'.
				'<tr><td class="tabsTd" colspan="2"><div id="tabs">'.$contents['tabs'].'</div></td></tr>'.
			'</table>'.
			'</td>'.
		'</tr>'.
	'</table>'.
	'</div>'.

	'<div id="wlcmUserLine" class="wlcmUserLine">'.$contents['wlcm'].'</div>'.

	'<div id="mainContent" class="mainContent">'.$contents['page'].'</div>'.

'</div>'.//mainContainer (end)
'</center>'.
'</body>'.


'<script type="text/javascript">'.$contents['js_code'].'</script>'.



'</html>';

echo $page_contet;
