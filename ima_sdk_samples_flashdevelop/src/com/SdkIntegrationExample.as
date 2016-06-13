
package com {
 
import flash.external.ExternalInterface;
import flash.net.URLLoader;
import flash.net.URLRequest;
import flash.net.URLLoaderDataFormat;
import flash.net.URLRequestMethod;
import flash.events.Event;
import XML;
 
  public class SdkIntegrationExample {

   

    
    public function SdkIntegrationExample(adTagUrl:String):void 
	{
		ExternalInterface.addCallback("test", sayHello);
		var request:URLRequest = new URLRequest(adTagUrl);
 
		var loader:URLLoader = new URLLoader();
		loader.dataFormat = URLLoaderDataFormat.TEXT;
		loader.addEventListener(Event.COMPLETE, handleResults);
		loader.load(request);
		
    }
	function sayHello():void
	{
		ExternalInterface.call("alert", "asdf");
	}
	
	function handleResults(evt:Event):void
	{
		var response:String = evt.target.data as String;
		var xmlData:XML;
	 
		try
		{
			xmlData = new XML(response);
			var x:String = xmlData.Ad.Wrapper.toString();
			if ( x == "") 
			{
				ExternalInterface.call("receiveTextFromAS3", xmlData.toString());
			}
			else{
				var wrap:String = xmlData.Ad.Wrapper.VASTAdTagURI.toString();
				var request:URLRequest = new URLRequest(wrap);
				var loader:URLLoader = new URLLoader();
				loader.dataFormat = URLLoaderDataFormat.TEXT;
				loader.addEventListener(Event.COMPLETE, handleResults);
				loader.load(request);
			}
		}
		catch(error:TypeError)
		{
			trace("the response data was not in valid XML format");
		}
	}
	
	
	

    
}
}
