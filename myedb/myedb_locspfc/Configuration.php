<?php
//adapted from http://www-128.ibm.com/developerworks/library/os-php-config/index.html
class Configuration
{
  	private $configFile; 

	function __construct()
	{
		$this->configFile = dirname(__FILE__) .'/myent_settings.xml';
		$this->parse();
	}

  private $items = array();

  function __get($id) { return $this->items[ $id ]; }

  function parse()
  {
    $doc = new DOMDocument();
    $doc->load( $this->configFile );

    $cn = $doc->getElementsByTagName( "config" );

    $nodes = $cn->item(0)->getElementsByTagName( "*" );
    foreach( $nodes as $node )
      $this->items[ $node->nodeName ] = $node->nodeValue;
  }
}
?>