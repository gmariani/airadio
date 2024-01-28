package com.coursevector.airadio {
	
    import flash.desktop.Icon;
    import flash.display.Loader;
    import flash.events.Event;
    import flash.net.URLRequest;
     
    public class MenuIcon extends Icon {      		
		private var imageURLs:Array = ['icons/AIRadio_16.png','icons/AIRadio_32.png',	'icons/AIRadio_48.png','icons/AIRadio_128.png'];
		
        public function MenuIcon():void {
            super();
            bitmaps = new Array();
        }
        
        public function loadImages(event:Event = null):void {
        	if(event != null) bitmaps.push(event.target.content.bitmapData);
        	
        	if(imageURLs.length > 0) {
        		var loader:Loader = new Loader();
        		loader.contentLoaderInfo.addEventListener(Event.COMPLETE, loadImages, false, 0, true);
				loader.load(new URLRequest(imageURLs.pop()));
        	} else {
        		dispatchEvent(new Event(Event.COMPLETE, false, false));
        	}
        }
    }
}