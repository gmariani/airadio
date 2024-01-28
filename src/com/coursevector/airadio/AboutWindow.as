package com.coursevector.airadio {

	import fl.controls.Button;
	import flash.display.Loader;
	import flash.display.NativeWindowInitOptions;
	import flash.display.NativeWindowType;
	import flash.display.NativeWindow;
	import flash.display.MovieClip;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.geom.Point;
	import flash.net.navigateToURL;
	import flash.net.URLRequest;
	import flash.net.URLVariables;
	import flash.text.TextField;
	import flash.events.MouseEvent;
	import flash.text.TextFieldAutoSize;
	import com.greensock.easing.Linear;
	import com.greensock.TweenMax;
	import com.google.analytics.API;
	import com.google.analytics.AnalyticsTracker;
	import com.google.analytics.GATracker;
	import cv.managers.UpdateManager;

	public class AboutWindow extends NativeWindow {

		private var sprMain:MovieClip = new AboutScreen();
		private var txtMessage:TextField;
		private var btnOk:Button;
		private var mcEmblem:MovieClip;
		private var um:UpdateManager;
		protected var ldr:Loader;

		public function AboutWindow():void {
			// Init Window
			var winArgs:NativeWindowInitOptions = new NativeWindowInitOptions();
			winArgs.maximizable = false;
			winArgs.minimizable = true;
			winArgs.resizable = false;
			winArgs.type = NativeWindowType.NORMAL;
			super(winArgs);
			title = "About Course Vector AIRadio";
			this.width = 325;
			this.height = 200;

			// Init
			um = UpdateManager.instance;
			txtMessage = sprMain.getChildByName("txtMessage") as TextField;
			txtMessage.embedFonts = true;
			txtMessage.autoSize = TextFieldAutoSize.CENTER;
			txtMessage.htmlText = "Version : <b>" + um.currentVersion + "</b><br><br>© 2014 Gabriel Mariani<br><br><a href='http://blog.coursevector.com/airadio'><u>http://blog.coursevector.com/airadio</u></a>";

			//var tracker:AnalyticsTracker = new GATracker(sprMain, "UA-349755-7", "AS3", false);
			//tracker.trackPageview("/airadio/" + um.currentVersion + "/AboutScreen");

			btnOk = sprMain.getChildByName("btnOk") as Button;
			btnOk.addEventListener(MouseEvent.CLICK, onClickOk);

			mcEmblem = sprMain.getChildByName("mcEmblem") as MovieClip;
			mcEmblem.rotationX = 0;
			TweenMax.to(mcEmblem, 5, { rotationY:360, loop:true, ease:Linear.easeNone } );

			stage.align = StageAlign.TOP_LEFT;
			stage.scaleMode = StageScaleMode.NO_SCALE;
			stage.addChild(sprMain);
			stage.root.transform.perspectiveProjection.projectionCenter = new Point(mcEmblem.x, mcEmblem.y);

			this.addEventListener(Event.ADDED_TO_STAGE, initTracker);
		}

		private function initTracker(event:Event):void {
			var tracker:AnalyticsTracker = new GATracker(sprMain, "UA-349755-7", "AS3", false);
			tracker.trackPageview("/airadio/" + um.currentVersion + "/AboutScreen");
		}

		protected function completeHandler(e:Event):void {
			var mc:MovieClip = new MovieClip();
			mc.alpha = 0;
			mc.addChild(ldr);
			mc.buttonMode = true;
			mc.mouseChildren = false;
			mc.x = 150;
			mc.y = 125;
			this.stage.addChild(mc);
			TweenMax.to(mc, 0.5, { alpha:1 } );
			TweenMax.to(btnOk, 0.5, { y:165 } );
			TweenMax.to(this, 0.5, { height:240 } );
		}

		protected function errorHandler(e:Event):void {
			trace(e);
		}

		private function onClickOk(event:MouseEvent):void {
			close();
		}
	}
}