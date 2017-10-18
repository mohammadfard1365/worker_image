package workers
{
	import com.myflashlabs.utils.worker.WorkerBase;
	import flash.utils.ByteArray;
	import flash.display.Loader;
	import flash.events.Event;
	import flash.display.BitmapData;
	import flash.display.LoaderInfo;
	import flash.display.Bitmap;
	
	/**
	 * ...
	 * @author MyFlashLab Team - 1/28/2016 11:00 PM
	 */
	public class Worker1 extends WorkerBase
	{
		
		public function Worker1()
		{
		
		}
		
		// these methods must be public because they are called from the main thread.
		public function forLoop($myParam:int):void
		{
			var thisCommand:Function = arguments.callee;
			
			for (var i:int = 0; i < $myParam; i++)
			{
				// call this method to send progress to your delegate
				sendProgress(thisCommand, i);
			}
			
			// call this method as the final message from the worker. When this is called, you cannot send anymore "sendProgress"
			sendResult(thisCommand, $myParam);
		}
		
		public function loadImage(b:ByteArray) {
			var thisCommand:Function = arguments.callee;
			var loader:Loader = new Loader();
			loader.loadBytes(b);
			
			loader.contentLoaderInfo.addEventListener(Event.COMPLETE, function loaderComplete(event){
				var l:LoaderInfo = (event.target) as LoaderInfo;	
				var bitmapData:BitmapData = new BitmapData(500, 500, false);
				bitmapData.draw(l.loader);
				
				
				sendProgress(thisCommand, myBit.getPixels(myBit.rect),myBit.rect.width,myBit.rect.height);
			return;
				sendProgress(thisCommand, bitmapData);
				
			});
			return
			for (var i:int = 0; i < 100; i++)
			{
				sendProgress(thisCommand, 18);
			}
			//sendResult(thisCommand, 1000);
			
		}
		
	}
}